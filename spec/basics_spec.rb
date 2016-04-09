require_relative '../classes/decryptor'
require_relative '../modules/utils/hex'
require_relative '../modules/utils/my_base64'
require_relative 'web_resources'

describe 'Basics' do
  it 'Set 1 (Challenge 1): Convert Hex to Base64' do
    hex_string = '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'
    base64_string = 'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t'
    expect(MyBase64.encode(Hex.to_bytes(hex_string))).to eq(base64_string)
  end
end
