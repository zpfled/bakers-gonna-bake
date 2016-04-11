require_relative './xor'
require_relative './utils/utility'

module AES
  def self.decipher(key)
    Utility.enforce_argument_type(Array, key)

    XOR.gate
  end

  def matrix_multiply()

  end
end
