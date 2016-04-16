require_relative '../../classes/substitution_box'

describe SubstitutionBox do
  describe '#transform' do
    it 'transforms 0x9a to 0xb8' do
<<<<<<< HEAD
      expect(SubstitutionBox.new.transform(0x9a)).to eq 0Xb8
=======
      # expect(SubstitutionBox.new.transform(0x9a)).to eq 0Xb8
      # expect(SubstitutionBox.new.transform(0xdb)).to eq 0x9f
      expect(SubstitutionBox.new.sbox(0x9a)).to eq 0Xb8
>>>>>>> working sbox, but only the copied version
    end
  end
end