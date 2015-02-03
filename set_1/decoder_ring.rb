require_relative 'config'

module DecoderRing
  require 'base64'
  require 'utility'

  def self.single_substitution(input, key=nil)
    messages = {}
    keys = (key ? [key] : 0..255)
    keys.each do |k|
      potential_key = Array.new(Hex.to_bytes(input).length, k)
      message = Hex.to_plaintext(DecoderRing::XOR.fixed(Hex.to_bytes(input), potential_key))
      next if Utility::Plaintext.score(message) == 0
      messages[Utility::Plaintext.score(message)] = message
    end
    return (messages.max ? messages.max[1] : "")
  end

  def self.find_needle(haystack, method)
    potential_messages = {}
    Utility::Web.txt_file_to_array(haystack).each do |line|
      try = self.send(method, line)
      potential_messages[Utility::Plaintext.score(try)] = try
    end
    potential_messages.max
  end


  # Converter Modules ==========================================================

  module Plaintext

  end

  module Hex
    def self.to_base64(hex_string) # encodes hex_string into base 64 equivalent
      Base64.strict_encode64(to_plaintext(hex_string))
    end

    def self.to_plaintext(hex_string) # returns plaintext representation of hex_string
      to_bytes(hex_string).map(&:chr).join
    end

    def self.to_bytes(hex_string) # returns array of bytes as integers
      raise ArgumentError if hex_string.class != String
      hex_string.scan(/../).map do |byte|
        byte.to_i(16)
      end
    end
  end

  module XOR

    def self.repeating_key(input, key)
      raise ArgumentError if key.class != String
      input_bytes = (input.class == Array ? input : Plaintext.to_bytes(input))
      l = input_bytes.length
      key_bytes = Plaintext.to_bytes(key)
      counter = 0
      until key_bytes.length == l
        counter = 0 if counter > 2
        key_bytes << Plaintext.to_bytes(key[counter])[0]
        counter += 1
      end
      fixed(input_bytes, key_bytes)
    end

    def self.fixed(input, key) # return string of hexadecimal bytes
      raise ArgumentError if (input.class != Array || key.class != Array)
      encode(input, key).map do |byte|
        byte = byte.to_s(16)
        if byte.length == 1
          byte.prepend('0')
        end
        byte
      end.join
    end

    def self.encode(input, key)
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