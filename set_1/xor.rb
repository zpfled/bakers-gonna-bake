require_relative 'config'

module XOR
  require 'decoder_ring'

  def self.encode(hex_string, key)
    a = DecoderRing.hex_to_bytes(hex_string)
    b = DecoderRing.hex_to_bytes(key)
    fixed_xor(a, b).map do |byte|
      byte.to_s(16)
    end.join
  end

  def self.fixed_xor(input, key)
    raise ArgumentError if (input.class != Array || key.class != Array)
    result = []
    (0..input.length - 1).each do |index|
      result.push(input[index] ^ key[index])
    end
    result
  end
end
