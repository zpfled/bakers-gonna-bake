require_relative 'config'

class Crypto
  # require 'xor'
  require 'decoder_ring'

  def self.challenge_1(input)
    DecoderRing.hex_to_base64(input)
  end

  def self.challenge_2(input, key)
    XOR.encode(DecoderRing.hex_to_bytes(input), DecoderRing.hex_to_bytes(key))
  end

  def self.challenge_3(input)
    DecoderRing.single_substitution(input)
  end

  def self.challenge_4(input_url)
    DecoderRing.find_needle(input_url, :single_substitution)
  end
end