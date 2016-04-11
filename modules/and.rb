require_relative './utils/utility'

module AND

  def self.gate(byte1, byte2)
    Utility.enforce_argument_type(Fixnum, byte1)
    Utility.enforce_argument_type(Fixnum, byte2)

    bits1 = padded_binary_byte(byte1)
    bits2 = padded_binary_byte(byte2)

    output = ''
    (0..7).each do |i|
      output << (bits1[i] == bits2[i] ? bits1[i] : '0')
    end

    return output.to_i(2)
  end

  private

  def self.padded_binary_byte(byte)
    bits = byte.to_s(2)

    until bits.length == 8
      bits.prepend('0')
    end

    return bits
  end
end
