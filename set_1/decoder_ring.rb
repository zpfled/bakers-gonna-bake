require_relative 'config'

class DecoderRing
  attr_accessor :target, :min_key_size, :max_key_size, :keysize

  def initialize(opts)
    @target = (Utility.decode64(opts[:target_url]))
    @min_key_size = opts[:min_key_size] || 2
    @max_key_size = opts[:max_key_size] || 40
    @keysize = nil
  end

  def break_repeating_key_xor(source_bytes=target)
    p "source_bytes: #{source_bytes}"
    raise ArgumentError if source_bytes.class != Array
    # find_keysizes(source_bytes).each do |try_keysize|
    (28..29).each do |try_keysize|
      puts
      puts
      p "try_keysize: #{try_keysize}"
      puts
      puts
      transposed_blocks(source_bytes.dup, try_keysize).each do |block|
        find_key_for(block)
      end
    end
  end

  def find_needle
    potential_messages = {}
    target.split("\n").each do |line|
      try = XOR.single_substitution(line)
      next if Plaintext.score(try) < 10000
      potential_messages[Plaintext.score(try)] = try
    end
    potential_messages.max
  end

  def find_keysizes(source_bytes)
    raise ArgumentError if source_bytes.class != Array
    scores = score_keysizes(source_bytes).values.sort
    average_score = scores.reduce(:+) / scores.length
    score_keysizes(source_bytes).keep_if do |keysize, distance|
      distance < average_score
    end.keys
  end

  def transposed_blocks(source_bytes, keysize)
    p "calling transposed_blocks"
    raise ArgumentError if source_bytes.class != Array
    groups = Utility.groups_of(keysize, source_bytes)
    groups.transpose
  end

private

  def find_key_for(block)
    best_guesses = []
    p best_guesses << XOR.single_substitution(block)
    # key_data[:score]
  end

  def score_keysizes(source_bytes)
    raise ArgumentError if source_bytes.class != Array
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