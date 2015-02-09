system 'clear'
require_relative 'config'

context DecoderRing do
  let(:dr) do
    DecoderRing.new({
      target_url: "cryptopals.com/static/challenge-data/6.txt"
    })
  end

  describe '#break_repeating_key_xor' do

    it 'works great' do
      vanilla_ice = "Vanilla Ice is sellin' and you people are buyin' "
      expect(dr.break_repeating_key_xor_english.split("\n").include?(vanilla_ice)).to eq true
    end
  end
end

context MyBase64 do

  describe '#to_bytes' do
    it 'returns an array of bytes as integers' do
      input = "HUIfTQsPAh9PE048GmllH0kcDk4TAQsHThsBFkU2AB4BSWQgVB0dQzNTTmVS"
      output = [29, 66, 31, 77, 11, 15, 2, 31, 79, 19, 78, 60, 26, 105,
        101, 31, 73, 28, 14, 78, 19, 1, 11, 7, 78, 27, 1, 22, 69, 54, 0,
        30, 1, 73, 100, 32, 84, 29, 29, 67, 51, 83, 78, 101, 82]
      expect(MyBase64::Convert.to_bytes(input)).to eq output
    end
  end
end

context Hex do

  describe '::Convert' do

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
end

context Plaintext do

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

context Hamming do

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

context Utility do

  describe '#groups_of(n, array)' do
    it 'returns an array of arrays, each one of length n' do
      expect(Utility.groups_of(2, [1, 2, 3, 4])).to eq([[1, 2], [3, 4]])
    end

    it 'even the input length is not divisible by n, it only returns sets of n.length' do
      expect(Utility.groups_of(2, [1, 2, 3, 4, 5])).to eq([[1, 2], [3, 4]])
    end
  end
end