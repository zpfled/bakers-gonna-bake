class Polynomial
  attr_reader :bits, :exponents

  def initialize(bits)
    @bits = get_bits(bits)
    @exponents = get_exponents(@bits)
  end

  def *(polynomial)
    output_exponents = []

    exponents.each do |exponent|
      polynomial.exponents.each do |poly_exponent|
        output_exponents << (exponent + poly_exponent)
      end
    end

    new_exponents = output_exponents.sort.reverse.reject do |e|
      output_exponents.count(e) == 4
    end

    output_bits = '0' * (new_exponents.max + 1)

    new_exponents.each do |exponent|
      output_bits[exponent] = '1'
    end

    return output_bits.reverse
  end

  def %(polynomial)
    a, b = [bits, polynomial.bits].sort

    # reduce
    while a.length < b.length
      b = (a.to_i(2) ^ b[0..(a.length-1)].to_i(2)).to_s(2) << b[a.length..-1]
    end

    # final xor
    result = (a.to_i(2) ^ b.to_i(2)).to_s(2)

    # pad bits with leading zeros
    until result.length == 8
      result.prepend('0')
    end

    result
  end

  private

  def get_bits(bits)
    while bits.length < 9
      bits.prepend '0'
    end
    bits
  end

  def get_exponents(bits)
    exponents = []

    bits.reverse.chars.each_with_index do |bit, i|
      if bit == '1'
        exponents.unshift(i)
      else
        next
      end
    end

    return exponents
  end
end
