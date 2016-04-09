require_relative '../../../modules/utils/hex'

context Hex do
  let(:bytes) { [73, 39, 109] }
  let(:hex) { "49276d" }

  describe '#encode(hex_string)' do
    it 'converts a hex string to bytes' do
      expect(Hex.encode(bytes)).to eq hex
    end
  end

  describe '#to_bytes(hex_string)' do
    it 'converts bytes to a hex string' do
      expect(Hex.to_bytes(hex)).to eq bytes
    end
  end
end
