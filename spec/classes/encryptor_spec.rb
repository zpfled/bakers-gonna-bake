require_relative '../../classes/encryptor'
require_relative '../../modules/utils/hex'
require_relative '../../modules/utils/plaintext'

describe Encryptor do

  describe 'Set 1 (Challenge 5): #repeating_key_xor' do
    it 'implements repeating-key XOR' do
      message = %Q[Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal]
      key = "ICE"
      encrypted_message = "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f"
      encrypt = Encryptor.new(Plaintext, Hex)
      p encrypt.repeating_key_xor(message, key)
      expect(encrypt.repeating_key_xor(message, key)).to eq(encrypted_message)
    end
  end
end