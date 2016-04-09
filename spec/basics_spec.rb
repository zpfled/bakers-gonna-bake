require_relative '../modules/utils/hex'
require_relative '../modules/utils/my_base64'
require_relative 'web_resources'

describe 'Basics' do

  it 'Challenge 1: Convert Hex to Base64' do
    hex_string = '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'
    base64_string = 'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t'
    expect(MyBase64.encode(Hex.to_bytes(hex_string))).to eq(base64_string)
  end

  describe 'Challenge 2: XOR.fixed' do
    it 'takes two equal-length buffers and produces their XOR combination' do
      buffer_1 = '1c0111001f010100061a024b53535009181c'
      buffer_2 = '686974207468652062756c6c277320657965'
      desired_output = '746865206b696420646f6e277420706c6179'

      expect(
        XOR.fixed(
          Hex.to_bytes(buffer_1),
          Hex.to_bytes(buffer_2)
        )
      ).to eq(desired_output)
    end
  end

  describe 'Challenge 3: XOR.single_substitution' do
    it 'decrypts a hex-encoded string' do
      hex_string = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
      expect(XOR.single_substitution(hex_string)[:histogram])
      .to eq("Cooking MC's like a pound of bacon")
    end
  end

  describe 'Challenge 4: Decryptor.find_needle' do
    it 'detects single-character XOR' do
      url = "cryptopals.com/static/challenge-data/4.txt"
      base64_text = WebResources.challenge_4
      expect(Decryptor.new(text: base64_text).find_needle[1])
      .to eq("Now that the party is jumping\n")
    end
  end

  describe 'Challenge 5: XOR.repeating_key_encrypt' do
    it 'implements repeating-key XOR' do
      message = %Q[Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal]
      key = "ICE"
      encrypted_message = "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f"
      expect(XOR.repeating_key_encrypt(message, key)).to eq(encrypted_message)
    end
  end

  describe 'Challenge 6: Decryptor.break_repeating_key_xor_english' do
    it 'breaks repeating key xor, preferring English' do
      base64_text = WebResources.challenge_6
      decryption = Decryptor.new(text: base64_text).break_repeating_key_xor_english
      vanilla_ice = "Vanilla Ice is sellin' and you people are buyin' "
      expect(decryption.split("\n").include?(vanilla_ice)).to eq true
    end
  end
end
