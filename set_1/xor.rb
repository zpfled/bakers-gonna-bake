require_relative 'config'

module XOR

  def self.repeating_key(input, key)
    raise ArgumentError if key.class != String
    input_bytes = (input.class == Array ? input : Plaintext::Convert.to_bytes(input))
    key_bytes = Plaintext::Convert.to_bytes(key)
    counter = 0
    until key_bytes.length == input_bytes.length
      counter = 0 if counter > key.length - 1
      p key[counter]
      key_bytes << Plaintext::Convert.to_bytes(key[counter])[0]
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

  def self.single_substitution(input, key=nil)
    input_bytes = (input.class == Array ? input : Hex::Convert.to_bytes(input))
    messages = {}
    keys = (key ? [key] : 0..255)
    keys.each do |k|
      potential_key = Array.new(input_bytes.length, k)
      message = Hex::Convert.to_plaintext(XOR.fixed(input_bytes, potential_key))
      next if Plaintext.score(message) == 0
      messages[Plaintext.score(message)] = { message: message, key: k }
    end
    if messages.max
      single_substition_output_hash(messages.max)
    else
      return ""
    end
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

private

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