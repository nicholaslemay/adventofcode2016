require_relative 'most_frequent_letters'

describe MostFrequentLetters do

  it 'returns the most frequent letters in order of frequency' do
    expect(MostFrequentLetters.from('a')).to eq(['a'])
    expect(MostFrequentLetters.from('baacccc')).to eq(['c', 'a', 'b'])
    expect(MostFrequentLetters.from('baacccced')).to eq(['c', 'a', 'b', 'd','e'])

  end

  it 'ignores any non alpha characters' do
    expect(MostFrequentLetters.from('b-aa-cccc-5000')).to eq(['c', 'a', 'b'])
  end
end