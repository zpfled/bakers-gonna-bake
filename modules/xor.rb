require_relative './utils/hex'
require_relative './utils/plaintext'
require_relative './utils/utility'

module XOR

  # takes two buffers and produces their XOR combination, expanding the key size
  # until both buffers are equal length
  def self.repeating_key_gate(input_bytes, key_bytes)
    require_bytes(input_bytes, key_bytes)

    key_bytes = expand_key(key_bytes, input_bytes.length)
    gate(input_bytes, key_bytes)
  end


  # takes two equal-length buffers and produces their XOR combination
  # format is bytes by default, but can be Hex, Plaintext, or Base64
  def self.gate(input_bytes, key_bytes, format=nil)
    require_bytes(input_bytes, key_bytes)

    bytes = (0..input_bytes.length - 1).map do |index|
      input_bytes[index] ^ key_bytes[index]
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

  def self.expand_key(key_bytes, length)
    counter = 0

    until key_bytes.length == length
      counter = 0 if counter > key_bytes.length - 1
      key_bytes << key_bytes[counter]
      counter += 1
    end

    return key_bytes
  end

  # probaby not necessary
  def self.require_bytes(input=[], key=[])
    Utility.enforce_argument_type(Array, input)
    Utility.enforce_argument_type(Array, key)
    # Utility.enforce_argument_type(Byte, key[0])
    # Utility.enforce_argument_type(Byte, key[0])
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