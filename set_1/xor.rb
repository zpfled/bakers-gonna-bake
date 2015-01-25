require_relative 'config'

module XOR
  require 'decoder_ring'

  def self.encode(input, key) # return string of hexadecimal bytes
    raise ArgumentError if (input.class != Array || key.class != Array)
    fixed_xor(input, key).map do |byte|
      byte.to_s(16)
    end.join
  end

private

  def self.fixed_xor(input, key)
    raise ArgumentError if (input.class != Array || key.class != Array)
    result = []
    counter = 0
    (0..input.length - 1).each do |index|
      result.push(input[index] ^ key[index])
    end
    result
  end
end
