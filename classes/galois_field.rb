require_relative '../modules/utils/utility'
require_relative '../modules/and'
require_relative '../modules/xor'
require 'prime'


class GaloisField256
  def initialize

  end

  def add(x, y)
    XOR.gate(x, y)
  end

  def subtract(x, y)
    add(x, y)
  end


  def multiply(x, y)
    xbits = x.to_s(16)
    ybits = y.to_s(16)

    p xbits
  end

  def divide(x, y)
    XOR.gate(x, y)
  end

  def inverse_of(byte)
    divide([1], [byte])[0]
  end

  def reducer
    '100011011'
  end

  def operate(x, y, operator_sym)
    output = [x, y].reduce(operator_sym)

    if output > max
      remainder = output - max
      return remainder % output
    else
      return output
    end
  end

end
