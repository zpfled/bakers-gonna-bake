require_relative './utility'

module Hex
  def self.encode(bytes)
    Utility.enforce_argument_type(Array, bytes)
    bytes.map do |byte|
      hex_byte = byte.to_s(16)
      hex_byte.length == 1 ? "0#{hex_byte}" : hex_byte
    end.join
  end

  def self.to_bytes(hex_string)
    Utility.enforce_argument_type(String, hex_string)
    hex_string.scan(/../).map do |hex_byte|
      hex_byte.to_i(16)
    end
  end
end
