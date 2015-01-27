require_relative 'config'

class Crypto
  require 'decoder_ring'

  def self.challenge_1(input)
    DecoderRing::Hex.to_base64(input)
  end

  def self.challenge_2(input, key)
    DecoderRing::Encode::XOR.fixed_to_s(DecoderRing::Hex.to_bytes(input), DecoderRing::Hex.to_bytes(key))
  end

  def self.challenge_3(input)
    DecoderRing.single_substitution(input)
  end

  def self.challenge_4(input_url)
    DecoderRing.find_needle(input_url, :single_substitution)
  end

  def challenge_5(input_plaintext, key)
    DecoderRing::Encode.plaintext_to_hex(input_plaintext, key)
  end
end