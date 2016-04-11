require_relative './utils/hex'
require_relative './utils/plaintext'
require_relative './utils/utility'

module XOR

  def self.repeating_key_encrypt(input, key)
    Utility.enforce_argument_type(Array, input)
    Utility.enforce_argument_type(Array, key)

    counter = 0

    until key.length == input.length
      counter = 0 if counter > key.length - 1
      key << key[counter]
      counter += 1
    end

    gate(input, key)
  end

  # takes two equal-length buffers and produces their XOR combination
  # format is bytes by default, but can be Hex, Plaintext, or Base64
  def self.gate(input, key, format=nil)
    require_bytes(input, key)

    bytes = (0..input.length - 1).map do |index|
      input[index] ^ key[index]
    end

    return format ? format.encode(bytes) : bytes
  end

  def self.single_substitution(input, key=nil)
    require_bytes(input)

    messages = {}
    keys = (key ? [key] : 0..255)
    keys.each do |k|
      potential_key = Array.new(input.length, k)
      message = Plaintext.encode(XOR.gate(input, potential_key))
      next if Plaintext.score(message) == 0
      messages[Plaintext.score(message)] = { message: message, key: k }
    end
    if messages.max
      single_substition_output_hash(messages.max)
    else
      return ""
    end
  end

private

  def self.require_bytes(input=[], key=[])
    Utility.enforce_argument_type(Array, input)
    Utility.enforce_argument_type(Array, key)
  end

  def self.single_substition_output_hash(data)
    return {
        key: {
          ord: data[1][:key],
          char: data[1][:key].chr
          },
        histogram: data[1][:message],
        score: data[0] / data[1][:message].split("").length
      }
  end
end