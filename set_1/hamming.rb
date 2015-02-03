module Hamming
  def self.distance(bytes1, bytes2)
    raise ArgumentError if bytes1.class != Array || bytes2.class != Array
    return "both args must be of the same length" if bytes1.length != bytes2.length
    score = 0
    (0..bytes1.length - 1).each do |i|
      score += compare(bytes1[i], bytes2[i])
    end
    score
  end

  def self.compare(byte1, byte2)
    raise ArgumentError if byte1.class != Fixnum || byte2.class != Fixnum
    score = 0
    (0..7).each do |i|
      next if strict_binary(byte1)[i] == strict_binary(byte2)[i]
      score += 1
    end
    return score
  end

  def self.strict_binary(byte)
    raise ArgumentError if byte.class != Fixnum
    return byte.to_s(2) if byte.to_s(2).length == 8
    byte.to_s(2).prepend('0' * (8 - byte.to_s(2).length))
  end
end
