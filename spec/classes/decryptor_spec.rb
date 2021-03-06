require_relative '../../classes/decryptor'
require_relative '../../modules/utils/my_base64'
require_relative '../../modules/utils/plaintext'

describe Decryptor do

  describe 'Set 1  (Challenge 4): #find_english_line' do
    xit 'detects single-character XOR' do
      lines = WebResources.challenge_4.split("\n").map { |line| Hex.to_bytes(line) }
      decryption = Decryptor.new(MyBase64, Plaintext).find_english_line(lines)[1]

      expect(decryption).to eq("Now that the party is jumping\n")
    end
  end

  describe 'Set 1 (Challenge 6): #repeating_key_xor_to_english' do
    xit 'breaks repeating key xor (scoring plaintext against English letter freq)' do
      base64_text = WebResources.challenge_6
      decryption = Decryptor.new(MyBase64, Plaintext).repeating_key_xor_to_english(base64_text)
      vanilla_ice = "Vanilla Ice is sellin' and you people are buyin' "

      expect(decryption.split("\n").include?(vanilla_ice)).to eq true
    end
  end

  describe 'Set 1 (Challenge 7): #ecb' do
    it 'decrypts aes-128-ecb with a given key' do
      base64_text = WebResources.challenge_7
      key = Plaintext.to_bytes("YELLOW SUBMARINE")
      decryption = Decryptor.new(MyBase64, Plaintext).decrypt_aes(base64_text, key)

      p decryption
      # vanilla_ice = "Vanilla Ice is sellin' and you people are buyin' "

      # expect(decryption.split("\n").include?(vanilla_ice)).to eq true
    end
  end
end
