require_relative 'config'

module XOR

  def self.repeating_key(input, key)
    raise ArgumentError if key.class != String
    input_bytes = (input.class == Array ? input : Plaintext::Convert.to_bytes(input))
    l = input_bytes.length
    key_bytes = Plaintext::Convert.to_bytes(key)
    counter = 0
    until key_bytes.length == l
      counter = 0 if counter > 2
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
    messages = {}
    keys = (key ? [key] : 0..255)
    keys.each do |k|
      potential_key = Array.new(Hex::Convert.to_bytes(input).length, k)
      message = Hex::Convert.to_plaintext(XOR.fixed(Hex::Convert.to_bytes(input), potential_key))
      next if Plaintext.score(message) == 0
      messages[Plaintext.score(message)] = message
    end
    return (messages.max ? messages.max[1] : "")
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
end