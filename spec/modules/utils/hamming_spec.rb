require_relative '../../../modules/utils/hamming'

context Hamming do

  describe '#distance' do
    it 'returns the Hamming distance between two arrays of bytes' do
      control = Plaintext.to_bytes("control")
      test = Plaintext.to_bytes("this is a test")
      wokka = Plaintext.to_bytes("wokka wokka!!!")
      expect(Hamming.distance(control, control)).to eq 0
      expect(Hamming.distance(test, wokka)).to eq 37
    end
  end

  describe '#compare' do
    it 'returns the Hamming distance between 2 bytes' do
      expect(Hamming.compare(6, 4)).to eq 1
    end
  end

  describe '#strict_binary' do
    it 'returns an 8-char binary byte as a string' do
      expect(Hamming.strict_binary(2)).to eq '00000010'
      expect(Hamming.strict_binary(6)).to eq '00000110'
    end
  end

end
