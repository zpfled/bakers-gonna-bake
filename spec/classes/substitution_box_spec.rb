require_relative '../../classes/substitution_box'

describe SubstitutionBox do
  describe '#sub_bytes' do
    it 'transforms [0x9a] to [0xb8]' do
      expect(SubstitutionBox.new.sub_bytes([0x9a])).to eq [0Xb8]
    end
  end
end