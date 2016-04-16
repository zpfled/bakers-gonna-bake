require_relative '../../modules/s_box'

class Test
  include SBox
end

describe 'Sbox' do
  describe '#transform' do
    it 'transforms 0x9a to 0xb8' do
      expect(Test.new.sub_bytes([0x9a])).to eq [0Xb8]
    end
  end
end