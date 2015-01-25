require_relative 'config'

describe Crypto do

  describe 'set 1' do
    describe 'challenge 1' do
      it 'completed' do
        hex_string = '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'
        base64_string = 'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t'
        expect(Crypto.challenge_1(hex_string)).to eq(base64_string)
      end
    end

    describe 'challenge 2' do
      it 'completed' do
        hex_string = '1c0111001f010100061a024b53535009181c'
        key = '686974207468652062756c6c277320657965'
        result = '746865206b696420646f6e277420706c6179'
        expect(Crypto.challenge_2(hex_string, key)).to eq(result)
      end
    end

    describe 'challenge 3' do
      it 'completed' do
        hex_string = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
        Crypto.challenge_3(hex_string)
        expect(Crypto.challenge_3(hex_string)).to eq("Cooking MC's like a pound of bacon")
      end
    end
  end
end