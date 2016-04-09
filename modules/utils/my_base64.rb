require_relative './plaintext'
require_relative './utility'
require 'base64'

module MyBase64
  def self.encode(bytes)
    Utility.enforce_argument_type(Array, bytes)
    Base64.strict_encode64(Plaintext.encode(bytes))
  end

  def self.to_bytes(base64_string)
    Utility.enforce_argument_type(String, base64_string)
    Base64.decode64(base64_string).chars.map(&:ord)
  end
end
