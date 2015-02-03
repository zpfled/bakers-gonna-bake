require_relative 'config'

class DecoderRing
  attr_accessor :target, :min_key_size, :max_key_size, :keysize

  def initialize(opts)
    @target = Utility::Web.txt_file_string(opts[:target_url])
    @min_key_size = opts[:min_key_size] || 2
    @max_key_size = opts[:max_key_size] || 40
    p @min_key_size, @max_key_size
    @keysize = nil
  end

  def find_keysize(source=target)
    potential_keysizes = {}
    (min_key_size..max_key_size).each do |keysize|
      chunk1 = Plaintext::Convert.to_bytes(source[0..(keysize - 1)])
      puts
      p "keysize: #{keysize}"
      chunk2 = Plaintext::Convert.to_bytes(source[keysize..(keysize * 2 - 1)])
      p chunk1.length == chunk2.length
      p chunk1.length == keysize
      p "HAM: #{Hamming.distance(chunk1, chunk2)} / #{keysize}"
      p "HAM: #{(Hamming.distance(chunk1, chunk2) * 100) / keysize}"
      potential_keysizes[(Hamming.distance(chunk1, chunk2) * 100) / keysize] = keysize
    end
    return potential_keysizes.min[1]
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
end