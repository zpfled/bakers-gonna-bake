require_relative '../../../modules/utils/plaintext'

context Plaintext do
  let(:bytes) { [97] }
  let(:plaintext) { 'a' }

  describe '#encode' do
    it 'converts bytes to plaintext' do
      expect(Plaintext.encode(bytes)).to eq plaintext
    end
  end

  describe '#to_bytes(plain_text)' do
    it 'converts plaintext to bytes' do
      expect(Plaintext.to_bytes(plaintext)).to eq bytes
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
