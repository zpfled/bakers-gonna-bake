require_relative 'config'

class DecoderRing
  attr_accessor :target, :min_key_size, :max_key_size, :keysize

  def initialize(opts)
    @target = Utility::Web.txt_file_string(opts[:target_url])
    @min_key_size = opts[:min_key_size] || 2
    @max_key_size = opts[:max_key_size] || 40
    @keysize = nil
  end

  def break_repeating_key_xor(source=target)
    find_keysizes(source)
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

  def find_keysizes(source)
    score_keysizes(source).keep_if do |keysize, distance|
      distance <= 3
    end.keys
  end

private

  def score_keysizes(source)
    potential_keysizes = {}
    (min_key_size..max_key_size).each do |keysize|
      chunk1 = Hex::Convert.to_bytes(source)[0..(keysize - 1)]
      chunk2 = Hex::Convert.to_bytes(source)[keysize..(keysize * 2 - 1)]
      return potential_keysizes if chunk1.length != chunk2.length
      p potential_keysizes[keysize] = (Hamming.distance(chunk1, chunk2)) / keysize
    end
    potential_keysizes
  end
end