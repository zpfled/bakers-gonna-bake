class Converters
  require 'base64'

  def self.hex_to_base64(hex_string)
    Base64.strict_encode64(to_chars(hex_decode(hex_string)).join)
  end

  def self.hex_fixed_xor(hex_string, key)
    fixed_xor(hex_decode(hex_string), hex_decode(key)).map do |byte|
      byte.to_s(16)
    end.join
  end

  # create array of integers representing the value of each byte
  def self.hex_decode(hex_string)
    raise ArgumentError if hex_string.class != String
    hex_string.scan(/../).map do |byte|
      byte.to_i(16)
    end
  end

  # XOR one array of bytes (as integers) against another
  def self.fixed_xor(array, key)
    raise ArgumentError if (array.class != Array || key.class != Array)
    result = []
    (0..array.length - 1).each do |index|
      result.push(array[index] ^ key[index])
    end
    result
  end

  # utility functions
  def self.to_chars(array)
    raise ArgumentError if array.class != Array
    array.map(&:chr)
  end
end