require_relative '../../../modules/utils/my_base64'

describe MyBase64 do
  let(:base64_string) { "HUIfTQsPAh9PE048GmllH0kcDk4TAQsHThsBFkU2AB4BSWQgVB0dQzNTTmVS" }
  let(:bytes) { [29, 66, 31, 77, 11, 15, 2, 31, 79, 19, 78, 60, 26, 105,
           101, 31, 73, 28, 14, 78, 19, 1, 11, 7, 78, 27, 1, 22, 69, 54, 0,
           30, 1, 73, 100, 32, 84, 29, 29, 67, 51, 83, 78, 101, 82] }

  describe '#encode(base64_string)' do
    it 'converts a base64 string to bytes' do
      expect(MyBase64.encode(bytes)).to eq base64_string
    end
  end

  describe '#to_bytes' do
    it 'converts bytes to a base64 string' do
      expect(MyBase64.to_bytes(base64_string)).to eq bytes
    end
  end
end
