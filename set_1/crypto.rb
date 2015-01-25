require_relative 'config'

class Crypto
  # require 'xor'
  require 'decoder_ring'

  def self.challenge_1(input)
    DecoderRing.hex_to_base64(input)
  end

  def self.challenge_2(input, key)
    XOR.encode(input, key)
  end
end