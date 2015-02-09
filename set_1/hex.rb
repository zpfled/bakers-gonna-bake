require_relative 'config'

module Hex
  module Convert
    def self.to_base64(hex_string) # encodes hex_string into base 64 equivalent
      Utility.descriptive_error(String, hex_string)
      Base64.strict_encode64(to_plaintext(hex_string))
    end

    def self.to_plaintext(hex_string) # returns plaintext representation of hex_string
      Utility.descriptive_error(String, hex_string)
      to_bytes(hex_string).map(&:chr).join
    end

    def self.to_bytes(hex_string) # returns array of bytes as integers
      Utility.descriptive_error(String, hex_string)
      hex_string.scan(/../).map do |byte|
        byte.to_i(16)
      end
    end
  end
end
