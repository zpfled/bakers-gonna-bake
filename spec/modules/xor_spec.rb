require_relative '../../modules/xor'

describe XOR do

  describe 'Set 1 (Challenge 2): XOR.fixed' do
    it 'takes two equal-length buffers and produces their XOR combination' do
      buffer_1 = '1c0111001f010100061a024b53535009181c'
      buffer_2 = '686974207468652062756c6c277320657965'
      desired_output = '746865206b696420646f6e277420706c6179'

      expect(
        XOR.fixed(Hex.to_bytes(buffer_1), Hex.to_bytes(buffer_2), Hex)
      ).to eq(desired_output)
    end
  end

  describe 'Set 1 (Challenge 3): XOR.single_substitution' do
    it 'decrypts a hex-encoded string' do
      bytes = Hex.to_bytes("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736")
      expect(XOR.single_substitution(bytes)[:histogram])
      .to eq("Cooking MC's like a pound of bacon")
    end
  end
end
