require_relative '../constants'
require_relative '../spec/web_resources'
require_relative '../modules/aes'
require_relative '../modules/xor'
require_relative '../modules/utils/hex'
require_relative '../modules/utils/utility'

class Decryptor
  attr_accessor :encoded_bytes
  attr_reader :input_type, :output_type

  def initialize(input_type, output_type)
    Utility.enforce_argument_type(Module, input_type)
    Utility.enforce_argument_type(Module, output_type)

    @input_type = input_type
    @output_type = output_type
  end

  def decipher_aes(input, key_bytes)
    Utility.enforce_argument_type(String, input)
    Utility.enforce_argument_type(Array, key_bytes)

    input_bytes = input_type.to_bytes(input)
    AES.decipher(input_bytes, key_bytes)
  end

  def repeating_key_xor_to_english(input)
    Utility.enforce_argument_type(String, input)

    input_bytes = input_type.to_bytes(input)
    key_bytes = find_key_for(input_bytes, 28..29)
    message = XOR.repeating_key_gate(input_bytes, key_bytes)
    Plaintext.encode(message)
  end

  def find_english_line(lines_of_bytes)
    potential_messages = {}
    lines_of_bytes.each do |line|

      try = XOR.single_substitution(line)[:histogram]

      if Plaintext.score(try) > (line.length * MEAN_ENGLISH_CHAR_FREQUENCY)
        potential_messages[Plaintext.score(try)] = try
      else
        next
      end
    end

    return potential_messages.max
  end

  private

  def transposed_blocks(source_bytes, keysize)
    Utility.enforce_argument_type(Array, source_bytes)
    Utility.groups_of(keysize, source_bytes).transpose
  end

  def find_key_for(source_bytes, key_size_range)
    potential_keys = {}
    key_size_range.each do |try_keysize|
      key_bytes = []
      transposed_blocks(source_bytes.dup, try_keysize).each do |block|
        key_bytes << XOR.single_substitution(block)[:key][:ord]
      end
      potential_keys[Plaintext.score(key_bytes.join)] = key_bytes
    end
    return potential_keys.max[1]
  end

  def score_keysizes(source_bytes)
    Utility.enforce_argument_type(Array, source_bytes)
    potential_keysizes = {}
    (min_key_size..max_key_size).each do |keysize|

      hamming_distances = []

      (0..3).each do |i|
        chunk1 = source_bytes[i*keysize..keysize-1]
        chunk2 = source_bytes[(i+1)*keysize..2*keysize-1]
        next if chunk1.length != chunk2.length
        hamming_distances << Hamming.distance(chunk1, chunk2)
      end

      average_ham = hamming_distances.reduce(:+) / hamming_distances.length
      potential_keysizes[keysize] = average_ham

    end
    potential_keysizes
  end
end
