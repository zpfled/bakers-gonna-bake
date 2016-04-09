require_relative '../../../modules/utils/plaintext'

context Plaintext do

  describe '#to_bytes(plain_text)' do
    it 'returns array of bytes as integers' do
      expect(Plaintext.to_bytes('a')).to eq [97]
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
