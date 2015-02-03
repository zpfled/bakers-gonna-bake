require_relative 'config'

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
      gibberish = Plaintext.score((0..18).map { (65 + rand(26)).chr }.join.downcase)
      scoreboard = []
      100.times { scoreboard << (english > gibberish ? 1 : 0) }
      expect(scoreboard.sort[9..99].all? { |i| i == 1 }).to be true
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