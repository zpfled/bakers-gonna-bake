require_relative '../../modules/galois_field'
require_relative '../../modules/utils/hex'

describe GaloisField256 do

  describe '#add' do
    it '1 + 1 is 0' do
      expect(GaloisField256.add(1, 1)).to eq [0]
    end

    it '1 + 2 is 3' do
      expect(GaloisField256.add(1, 2)).to eq [3]
    end
  end

  describe '#muliply' do
    it 'muliply(7, 3) equals 9' do
      expect(GaloisField256.multiply(7, 3)).to eq 9
    end

    it 'multiply(83, 202) equals 1' do
      expect(GaloisField256.multiply(202, 83)).to eq 1
    end
  end

  describe '#multiplicative_inverse' do
    it 'the inverse of 1 is 1' do
      expect(GaloisField256.multiplicative_inverse(1)).to eq 1
    end

    it 'the inverse of HEX(53) is HEX(CA)' do
      byte53 = Hex.to_bytes('53')[0]

      byteCA = Hex.to_bytes('CA')[0]
      expect(GaloisField256.multiplicative_inverse(byte53)).to eq byteCA
    end
  end
end