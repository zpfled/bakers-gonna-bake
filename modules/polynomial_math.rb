require_relative './utils/byte'

module PolynomialMath

  def self.multiply(byte1, byte2)
    output_exponents = []

    exponents(byte1).each do |a|
      exponents(byte2).each do |b|
        output_exponents << (a + b)
      end
    end

    new_exponents = output_exponents.sort.reverse.reject do |e|
      output_exponents.count(e) == 4
    end

    output_bits = '0' * (new_exponents.max + 1)

    new_exponents.each do |exponent|
      output_bits[exponent] = '1'
    end

    return output_bits.reverse.to_i(2)
  end

  def self.modulo(byte1, byte2)
    a, b = [Byte.to_bits(byte1), Byte.to_bits(byte2)].sort

    # reduce
    while a.length < b.length
      b = (a.to_i(2) ^ b[0..(a.length-1)].to_i(2)).to_s(2) << b[a.length..-1]
    end

    # final xor
    (a.to_i(2) ^ b.to_i(2))
  end

  private

  def self.exponents(byte)
    exponents = []

    Byte.to_bits(byte).reverse.chars.each_with_index do |bit, i|
      if bit == '1'
        exponents.unshift(i)
      else
        next
      end
    end

    return exponents
  end
end
