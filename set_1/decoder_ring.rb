require_relative 'config'

class DecoderRing
  attr_accessor :target, :min_key_size, :max_key_size, :keysize

  def initialize(opts)
    @target = (Utility.decode64(opts[:target_url]))
    @min_key_size = opts[:min_key_size] || 2
    @max_key_size = opts[:max_key_size] || 40
    @keysize = nil
  end

  def break_repeating_key_xor_english(source_bytes=target)
    raise ArgumentError if source_bytes.class != Array
    # key_bytes = find_key_for(source_bytes, 28..29)
    # key = key_bytes.map {|i| i.to_s(16)}.join
    # p Hex::Convert.to_plaintext(key)
    message = (XOR.repeating_key(source_bytes, "Terminator X: Bring the noise"))
    Hex::Convert.to_plaintext(message)
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
      distance > average_score
    end.keys
  end

  def transposed_blocks(source_bytes, keysize)
    raise ArgumentError if source_bytes.class != Array
    groups = Utility.groups_of(keysize, source_bytes)
    groups.transpose
  end

private

  def find_key_for(source_bytes, key_size_range=(min_key_size..max_key_size))
    potential_keys = {}
    key_size_range.each do |try_keysize|
      key_bytes = []
      transposed_blocks(source_bytes.dup, try_keysize).each do |block|
        key_bytes << XOR.single_substitution(block)[:key][:ord]
      end
      potential_keys[Plaintext.score(key_bytes.join)] = key_bytes
    end
    p potential_keys.max[1].length
    return potential_keys.max[1]
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