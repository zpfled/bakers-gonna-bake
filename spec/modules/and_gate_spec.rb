require_relative '../../modules/and'

describe AND do

  it '0 AND 0 returns 0' do
    expect(AND.gate(0, 0)).to eq 0
  end

  it '1 AND 1 returns 1' do
    expect(AND.gate(1, 1)).to eq 1
  end

  it '3 AND 5 returns 1' do
    expect(AND.gate(3, 5)).to eq 1
  end

  it '4 AND 5 returns 3' do
    expect(AND.gate(4, 5)).to eq 4
  end
end