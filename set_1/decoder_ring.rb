require_relative 'config'

module DecoderRing
  require 'base64'
  require 'xor'
  require 'utility'

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

    def self.single_substitution(input)
      messages = {}
      (0..255).each do |k|
        potential_key = Array.new(hex_to_bytes(input).length, k)
        message = hex_to_plaintext(XOR.encode(hex_to_bytes(input), potential_key))
        messages[Utility::Plaintext.score(message)] = message
      end
      return messages.max[1]
    end

    def self.find_needle(haystack, method)
      potential_messages = {}
      Utility::Web.txt_file_to_array(haystack).each do |line|
        try = self.send(method, line)
        potential_messages[Utility::Plaintext.score(try)] = try
      end
      potential_messages.max
    end


  # ====
end