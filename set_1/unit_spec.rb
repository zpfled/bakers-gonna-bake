system 'clear'
require_relative 'config'

describe DecoderRing do
  let(:dr) do
    DecoderRing.new({
      target_url: "cryptopals.com/static/challenge-data/6.txt"
    })
  end

  describe '#break_repeating_key_xor' do
    let(:message) { "This code is going to turn out to be surprisingly useful later on. Breaking repeating-key XOR ('Vigenere') statistically is obviously an academic exercise, a 'Crypto 101' thing. But more people 'know how' to break it than can actually break it, and a similar technique breaks something much more important." }

    describe '#find_keysizes' do
      it 'returns an array of potential keysizes, including the correct one' do
        msg = Hex::Convert.to_bytes(XOR.repeating_key(message, 'key'))
        result = dr.find_keysizes(msg)
        expect(result.include?(3)).to be true

        msg = Hex::Convert.to_bytes(XOR.repeating_key(message, 'matasano'))
        result = dr.find_keysizes(msg)
        expect(result.include?(8)).to be true

        msg = Hex::Convert.to_bytes(XOR.repeating_key(message, 'challenges'))
        result = dr.find_keysizes(msg)
        expect(result.include?(10)).to be true

        msg = Hex::Convert.to_bytes(XOR.repeating_key(message, 'matasano challenges'))
        result = dr.find_keysizes(msg)
        expect(result.include?(19)).to be true
      end
    end

    it 'works great' do
      p dr.break_repeating_key_xor()
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

describe Utility do

  describe '#groups_of(n, array)' do
    it 'returns an array of arrays, each one of length n' do
      expect(Utility.groups_of(2, [1, 2, 3, 4])).to eq([[1, 2], [3, 4]])
    end

    it 'even the input length is not divisible by n, it handles things well' do
      expect(Utility.groups_of(2, [1, 2, 3, 4, 5])).to eq([[1, 2], [3, 4], [5]])
    end
  end
end