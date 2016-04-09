require_relative '../../../modules/utils/plaintext'
require_relative '../../../modules/utils/pkcs'

describe PKCS do

  describe 'Set 2 (Challenge 1): #pad' do
    it 'pads an array of bytes to the desired length' do
      bytes = Plaintext.to_bytes("YELLOW SUBMARINE")
      padded_bytes = PKCS.pad(bytes, 20)
      expect(Plaintext.encode(padded_bytes)).to eq "YELLOW SUBMARINE\x04\x04\x04\x04"
    end
  end
end
