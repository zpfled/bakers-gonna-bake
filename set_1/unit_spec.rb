# system 'clear'
require_relative 'config'

describe DecoderRing do
  let(:dr) do
    DecoderRing.new({
      target_url: "cryptopals.com/static/challenge-data/4.txt",
      max_key_size: 20
    })
  end

  describe '#find_keysize' do
    it 'returns the most likely keysize for repeating key XOR' do
      source = "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d62"
      p dr.find_keysize(source)
      expect(dr.find_keysize(source)).to eq(3)
      # source = "2300060b06171c41131d0452020e000a41100a00071b08141a0d521b0913014110000c101c"
      # expect(dr.find_keysize(source)).to eq(4)
    end
  end
end

describe Hex do

  describe '#to_plaintext(hex_string)' do
    it 'returns plaintext representation of hex_string' do
      input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
      output = "I'm killing your brain like a poisonous mushroom"
      expect(Hex.to_plaintext(input)).to eq output
    end
  end

  describe '#to_bytes(hex_string)' do
    it 'returns array of bytes as integers' do
      input = "49276d"
      output = [73, 39, 109]
      expect(Hex.to_bytes(input)).to eq output
    end
  end
end

describe Plaintext do

  describe '::Convert' do
    describe '#to_bytes(plain_text)' do
      it 'returns array of bytes as integers' do
        expect(Plaintext::Convert.to_bytes('a')).to eq [97]
      end
    end

    describe '#to_base64(plain_text)' do
      it 'encodes plaintext_string into base 64 equivalent' do
        expect(Plaintext::Convert.to_base64('a')).to eq(Base64.strict_encode64('a'))
      end
    end
  end

  describe '#score(plain_text)' do
    it 'returns a score, high scores indicating a strong likelihood of being English' do
      english = Plaintext.score('The quick brown fox')
      scoreboard = []
      1000.times do
        scoreboard << (english > Plaintext.score((0..18).map do
          (65 + rand(26)).chr
        end.join.downcase) ? 1 : 0)
      end
      expect(scoreboard.sort[99..999].all? { |i| i == 1 }).to be true
    end
  end
end

describe Hamming do

  describe '#distance' do
    it 'returns the Hamming distance between two arrays of bytes' do
      test = Plaintext::Convert.to_bytes("this is a test")
      wokka = Plaintext::Convert.to_bytes("wokka wokka!!!")
      expect(Hamming.distance(test, wokka)).to eq 37
    end
  end

  describe '#compare' do
    it 'returns the Hamming distance between 2 bytes' do
      expect(Hamming.compare(6, 4)).to eq 1
    end
  end

  describe '#strict_binary' do
    it 'returns an 8-char binary byte as a string' do
      expect(Hamming.strict_binary(2)).to eq '00000010'
      expect(Hamming.strict_binary(6)).to eq '00000110'
    end
  end
end