require_relative '../modules/xor'
require_relative '../modules/utils/hex'
require_relative '../modules/utils/utility'

class Decryptor
  attr_accessor :text, :min_key_size, :max_key_size, :keysize

  def initialize(opts)
    # String to decode
    @text = opts[:text]
    @min_key_size = opts[:min_key_size] || 2
    @max_key_size = opts[:max_key_size] || 40
    @keysize = nil
  end

  def break_repeating_key_xor_english(source_bytes=text_bytes)
    Utility.enforce_argument_type(Array, source_bytes)
    key_bytes = find_key_for(source_bytes, 28..29)
    hex_string = Hex.encode(key_bytes)
    message = XOR.repeating_key_encrypt(source_bytes, Plaintext.encode(Hex.to_bytes(hex_string)))
    Plaintext.encode(Hex.to_bytes(message))
  end

  def find_needle
    potential_messages = {}
    text.split("\n").each do |line|
      try = XOR.single_substitution(line)[:histogram]
      next if Plaintext.score(try) < 10000
      potential_messages[Plaintext.score(try)] = try
    end
    potential_messages.max
  end

  def find_keysizes(source_bytes)
    Utility.enforce_argument_type(Array, source_bytes)
    scores = score_keysizes(source_bytes).values.sort
    average_score = scores.reduce(:+) / scores.length
    score_keysizes(source_bytes).keep_if do |keysize, distance|
      distance > average_score
    end.keys
  end

  def transposed_blocks(source_bytes, keysize)
    Utility.enforce_argument_type(Array, source_bytes)
    Utility.groups_of(keysize, source_bytes).transpose
  end

private

  def text_bytes
    MyBase64.to_bytes(text)
  end

  def find_key_for(source_bytes, key_size_range=(min_key_size..max_key_size))
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