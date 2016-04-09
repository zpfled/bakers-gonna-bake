require_relative '../../classes/decryptor'
require_relative '../../modules/utils/my_base64'
require_relative '../../modules/utils/plaintext'

describe Decryptor do

  describe 'Set 1  (Challenge 4): #find_english_line' do
    it 'detects single-character XOR' do
      lines = WebResources.challenge_4.split("\n").map { |line| Hex.to_bytes(line) }
      decryption = Decryptor.new(MyBase64, Plaintext).find_english_line(lines)[1]

      expect(decryption).to eq("Now that the party is jumping\n")
    end
  end

  describe 'Set 1 (Challenge 6): #repeating_key_xor_to_english' do
    it 'breaks repeating key xor (scoring plaintext against English letter freq)' do
      base64_text = WebResources.challenge_6
      decryption = Decryptor.new(MyBase64, Plaintext).repeating_key_xor_to_english(base64_text)
      vanilla_ice = "Vanilla Ice is sellin' and you people are buyin' "

      expect(decryption.split("\n").include?(vanilla_ice)).to eq true
    end
  end
end
