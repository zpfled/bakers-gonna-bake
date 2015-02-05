# system 'clear'
require_relative 'config'

describe DecoderRing do
  let(:dr) do
    DecoderRing.new({
      target_url: "cryptopals.com/static/challenge-data/4.txt",
      max_key_size: 10
    })
  end

  describe '#break_repeating_key_xor' do
    let(:message) do
      str = ""
      100.times { str<<('a'..'z').to_a.sample }
      Plaintext::Convert.to_bytes(str).map { |byte| byte.to_s(16) }.join
    end
    let(:key) { 'key' }

    describe '#find_keysizes' do
      it 'returns an array of potential keysizes, including the correct one' do
        100.times { expect(dr.find_keysizes(message).include?(3)).to be true }
      end
    end

    xit 'returns the most likely keysize for repeating key XOR' do
      message = Plaintext::Convert.to_bytes("I'm killing your brain like a poisonous mushroom")
      key = "key"
      source = XOR.repeating_key(message, key)
      expect(dr.find_keysizes(source)).to eq(10)
    end
  end
end

describe Hex do

  describe '#to_plaintext(hex_string)' do
    it 'returns plaintext representation of hex_string' do
      input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
      output = "I'm killing your brain like a poisonous mushroom"
      expect(Hex::Convert.to_plaintext(input)).to eq output
    end
  end

  describe '#to_bytes(hex_string)' do
    it 'returns array of bytes as integers' do
      input = "49276d"
      output = [73, 39, 109]
      expect(Hex::Convert.to_bytes(input)).to eq output
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
      control = Plaintext::Convert.to_bytes("control")
      test = Plaintext::Convert.to_bytes("this is a test")
      wokka = Plaintext::Convert.to_bytes("wokka wokka!!!")
      expect(Hamming.distance(control, control)).to eq 0
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