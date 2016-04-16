require_relative '../../modules/aes'
require_relative '../../modules/utils/hex'

class Test
  include AES
end

describe 'AES' do
  describe '#key_expansion_128' do
    it 'creates an expanded key' do
      # Tests are from http://www.samiam.org/key-schedule.html
      input = Hex.to_bytes('00000000000000000000000000000000')
      output = Hex.to_bytes('00000000000000000000000000000000626363636263636362636363626363639b9898c9f9fbfbaa9b9898c9f9fbfbaa90973450696ccffaf2f457330b0fac99ee06da7b876a1581759e42b27e91ee2b7f2e2b88f8443e098dda7cbbf34b9290ec614b851425758c99ff09376ab49ba7217517873550620bacaf6b3cc61bf09b0ef903333ba9613897060a04511dfa9fb1d4d8e28a7db9da1d7bb3de4c664941b4ef5bcb3e92e21123e951cf6f8f188e')
      expect(Test.new.key_expansion_128(input)).to eq output

      input = Hex.to_bytes('ffffffffffffffffffffffffffffffff')
      output = Hex.to_bytes('ffffffffffffffffffffffffffffffffe8e9e9e917161616e8e9e9e917161616adaeae19bab8b80f525151e6454747f0090e2277b3b69a78e1e7cb9ea4a08c6ee16abd3e52dc2746b33becd8179b60b6e5baf3ceb766d488045d385013c658e671d07db3c6b6a93bc2eb916bd12dc98de90d208d2fbb89b6ed5018dd3c7dd15096337366b988fad054d8e20d68a5335d8bf03f233278c5f366a027fe0e0514a3d60a3588e472f07b82d2d7858cd7c326')
      expect(Test.new.key_expansion_128(input)).to eq output

      input = Hex.to_bytes('000102030405060708090a0b0c0d0e0f')
      output = Hex.to_bytes('000102030405060708090a0b0c0d0e0fd6aa74fdd2af72fadaa678f1d6ab76feb692cf0b643dbdf1be9bc5006830b3feb6ff744ed2c2c9bf6c590cbf0469bf4147f7f7bc95353e03f96c32bcfd058dfd3caaa3e8a99f9deb50f3af57adf622aa5e390f7df7a69296a7553dc10aa31f6b14f9701ae35fe28c440adf4d4ea9c02647438735a41c65b9e016baf4aebf7ad2549932d1f08557681093ed9cbe2c974e13111d7fe3944a17f307a78b4d2b30c5')
      expect(Test.new.key_expansion_128(input)).to eq output
    end
  end
end