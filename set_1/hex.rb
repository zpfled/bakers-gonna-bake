require_relative 'config'

module Hex
  module Convert
    def self.to_base64(hex_string) # encodes hex_string into base 64 equivalent
      raise ArgumentError if hex_string.class != String
      Base64.strict_encode64(to_plaintext(hex_string))
    end

    def self.to_plaintext(hex_string) # returns plaintext representation of hex_string
      raise ArgumentError if hex_string.class != String
      to_bytes(hex_string).map(&:chr).join
    end

    def self.to_bytes(hex_string) # returns array of bytes as integers
      raise ArgumentError if hex_string.class != String
      hex_string.scan(/../).map do |byte|
        byte.to_i(16)
      end
    end
  end
end
