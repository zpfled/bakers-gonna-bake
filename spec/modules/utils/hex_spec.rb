require_relative '../../../modules/utils/hex'

context Hex do

  describe '#encode(hex_string)' do
    it 'converts the hex_string to bytes' do
      bytes = [73, 39, 109]
      hex = "49276d"
      expect(Hex.encode(bytes)).to eq hex
    end
  end

  describe '#to_bytes(hex_string)' do
    it 'returns array of bytes as integers' do
      hex = "49276d"
      bytes = [73, 39, 109]
      expect(Hex.to_bytes(hex)).to eq bytes
    end
  end
end
