require_relative '../modules/galois_field'
require_relative '../modules/utils/byte'
require_relative '../modules/xor'

class SubstitutionBox
  def transform(n)
    # Store the multiplicative inverse of the input number in two 8-bit unsigned
    # temporary variables: s and x
    s = x = GaloisField256.multiplicative_inverse(n)

    # For a total of four iterations:
    # - Rotate the value s one bit to the left; if the value of s had a high bit
    #   (eight bit from the left) of one, make the low bit of s one; otherwise the
    #   low bit of s is zero.
    # - Exclusive or the value of x with the value of s, storing the value in x

    4.times do
      s = rotate_bits(s)
      x = XOR.gate([s], [x])[0]
    end

    # The value of ''x'' will now have the transformed value.
    XOR.gate([x], [99])[0]
  end

private

  def rotate_bits(byte)
    p bits = Byte.to_bits(byte, true).split('').rotate.join
    Byte.from_bits(bits)
  end
end