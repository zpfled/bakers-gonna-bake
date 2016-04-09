require_relative '../../../modules/utils/utility'

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
