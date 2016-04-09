require_relative '../modules/xor'
require_relative '../modules/utils/plaintext'
require_relative '../modules/utils/utility'

class Encryptor

  def repeating_key(input, key)
    Utility.enforce_argument_type(String, key)
    input_bytes = (input.class == Array ? input : Plaintext.to_bytes(input))
    key_bytes = Plaintext.to_bytes(key)
    counter = 0
    until key_bytes.length == input_bytes.length
      counter = 0 if counter > key.length - 1
      key_bytes << Plaintext.to_bytes(key[counter])[0]
      counter += 1
    end
    fixed(input_bytes, key_bytes)
  end
end