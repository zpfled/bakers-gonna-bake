require_relative '../modules/xor'
require_relative '../modules/utils/utility'

class Encryptor
  attr_reader :input_type, :output_type

  def initialize(input_type, output_type)
    Utility.enforce_argument_type(Module, input_type)
    Utility.enforce_argument_type(Module, output_type)

    @input_type = input_type
    @output_type = output_type
  end

  def repeating_key_xor(input, key)
    Utility.enforce_argument_type(String, input)
    Utility.enforce_argument_type(String, key)

    input_bytes = input_type.to_bytes(input)
    key_bytes = input_type.to_bytes(key)
    return output_type.encode(XOR.repeating_key_gate(input_bytes, key_bytes))
  end
end