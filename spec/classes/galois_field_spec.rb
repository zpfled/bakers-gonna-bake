require_relative '../../classes/galois_field'
require_relative '../../modules/utils/hex'

describe GaloisField256 do

  describe '#add' do
    it '1 + 1 is 2' do
      gf = GaloisField256.new
      expect(gf.add(1, 1)).to eq 2
    end

    it '1 + 2 is 1' do
      gf = GaloisField256.new
      expect(gf.add(1, 2)).to eq 1
    end
  end

  describe '#inverse_of' do
    it 'the inverse of 1 is 1' do
      gf = GaloisField256.new
      expect(gf.inverse_of(1)).to eq 1
    end

    it 'the inverse of HEX(53) is HEX(CA)' do
      gf = GaloisField256.new
      byte53 = Hex.to_bytes('53')[0]
      p byte53

      byteCA = Hex.to_bytes('CA')[0]
      p byteCA
      expect(gf.inverse_of(byte53)).to eq byteCA
    end
  end

  describe '#to_polynomial'
end
