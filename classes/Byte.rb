class Byte
  attr_reader :bits, :hex, :value

  def initialize(number)
    raise ArgumentError if invalid_number?

    @bits = number.to_s(2)
    @hex = number.to_s(16)
    @value = number
  end

  private

  def invalid_number?(n)
    n < 0 || n > 255
  end
end