require_relative '../../classes/polynomial'

describe Polynomial do

  describe '#initialize' do
    it 'creates an array of exponents' do
      a = Polynomial.new('1010011')
      expect(a.exponents).to eq [6, 4, 1, 0]

      b = Polynomial.new('11001010')
      expect(b.exponents).to eq [7, 6, 3, 1]
    end
  end

  describe '*' do
    it 'performs polynomial multiplication' do
      a = Polynomial.new('1010011')
      b = Polynomial.new('11001010')

      expect(a * b).to eq '11111101111110'
    end
  end

  describe '%' do
    it 'performs polynomial modulus' do
      a = Polynomial.new('11111101111110')
      b = Polynomial.new('100011011')

      expect(a % b).to eq '00000001'
    end
  end

end
