require_relative 'config'

module DecoderRing
  require 'base64'
  require 'xor'

  # Decode Hexadecimal Strings
    def self.hex_to_base64(hex_string) # encodes hex_string into base 64 equivalent
      Base64.strict_encode64(hex_to_plaintext(hex_string))
    end

    def self.hex_to_plaintext(hex_string) # returns plaintext representation of hex_string
      hex_to_bytes(hex_string).map(&:chr).join
    end

    def self.hex_to_bytes(hex_string) # returns array of bytes as integers
      raise ArgumentError if hex_string.class != String
      hex_string.scan(/../).map do |byte|
        byte.to_i(16)
      end
    end

  # ====
end