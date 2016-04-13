require_relative '../../modules/polynomial_math'

describe PolynomialMath do

  describe '#exponents' do
    it 'creates an array of exponents' do
      expect(PolynomialMath.exponents(83)).to eq [6, 4, 1, 0]
      expect(PolynomialMath.exponents(202)).to eq [7, 6, 3, 1]
    end
  end

  describe '#multiply' do
    it 'performs polynomial multiplication' do
      expect(PolynomialMath.multiply(83, 202)).to eq 16254
      expect(PolynomialMath.multiply(202, 83)).to eq 16254
    end
  end

  describe '#modulo' do
    it 'performs polynomial modulus' do
      expect(PolynomialMath.modulo(16254, 283)).to eq 1
    end
  end
end
