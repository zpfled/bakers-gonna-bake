require_relative 'config'

module DecoderRing
  require 'base64'
  require 'utility'

  def self.single_substitution(input)
    messages = {}
    (0..255).each do |k|
      potential_key = Array.new(Hex.to_bytes(input).length, k)
      message = Hex.to_plaintext(DecoderRing::Encode::XOR.fixed_to_s(Hex.to_bytes(input), potential_key))
      messages[Utility::Plaintext.score(message)] = message
    end
    return messages.max[1]
  end

  module Hex
  # Decode Hexadecimal Strings
    def self.to_base64(hex_string) # encodes hex_string into base 64 equivalent
      Base64.strict_encode64(Hex.to_plaintext(hex_string))
    end

    def self.to_plaintext(hex_string) # returns plaintext representation of hex_string
      Hex.to_bytes(hex_string).map(&:chr).join
    end

    def self.to_bytes(hex_string) # returns array of bytes as integers
      raise ArgumentError if hex_string.class != String
      hex_string.scan(/../).map do |byte|
        byte.to_i(16)
      end
    end
  end

  def self.find_needle(haystack, method)
    potential_messages = {}
    Utility::Web.txt_file_to_array(haystack).each do |line|
      try = self.send(method, line)
      potential_messages[Utility::Plaintext.score(try)] = try
    end
    potential_messages.max
  end

  module Encode

    module XOR
      def self.fixed_to_s(input, key) # return string of hexadecimal bytes
        raise ArgumentError if (input.class != Array || key.class != Array)
        fixed(input, key).map do |byte|
          byte.to_s(16)
        end.join
      end

      def self.fixed(input, key)
        raise ArgumentError if (input.class != Array || key.class != Array)
        result = []
        counter = 0
        (0..input.length - 1).each do |index|
          result.push(input[index] ^ key[index])
        end
        result
      end
    end
  end

  module Plaintext
    def self.to_hex(plaintext, key)
      true
    end
  end
end