require_relative 'config'

class Crypto
  require 'decoder_ring'

  def self.challenge_1(input)
    Hex.to_base64(input)
  end

  def self.challenge_2(input, key)
    DecoderRing::XOR.fixed(Hex.to_bytes(input), Hex.to_bytes(key))
  end

  def self.challenge_3(input)
    XOR.single_substitution(input)
  end

  def self.challenge_4(input_url)
    DecoderRing.new(target_url: input_url).find_needle
  end

  def self.challenge_5(input_plaintext, key)
    DecoderRing::XOR.repeating_key(input_plaintext, key)
  end
end