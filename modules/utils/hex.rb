require_relative './utility'

module Hex
  def self.encode(bytes)
    Utility.enforce_argument_type(Array, bytes)
    bytes.map { |byte| byte.to_s(16) }.join
  end

  def self.to_bytes(hex_string)
    Utility.enforce_argument_type(String, hex_string)
    hex_string.scan(/../).map do |byte|
      byte.to_i(16)
    end
  end
end
