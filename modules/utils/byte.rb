module Byte

  # From Byte
  def self.to_bits(byte, strict=false)
    if strict
      bits = byte.to_s(2)
      while bits.length < 9
        bits.prepend('0')
      end
      p bits
    else
      byte.to_s(2)
    end
  end


  # To Byte
  def self.from_bits(bits)
    bits.to_i(2)
  end

  def self.from_hex(hex_string)
    hex_string.to_i(16)
  end
end