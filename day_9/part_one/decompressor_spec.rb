require_relative 'decompressor'

describe Decompressor do

  it 'leaves a string sequence without compression marker as is' do
    expect(Decompressor.decompress('ADVENT')).to eq('ADVENT')
  end

  it 'repeats the number of letter for the number of times in the marker' do
    expect(Decompressor.decompress('A(1x5)BC')).to eq('ABBBBBC')
    expect(Decompressor.decompress('(3x3)XYZ')).to eq('XYZXYZXYZ')
    expect(Decompressor.decompress('A(2x2)BCD(2x2)EFG')).to eq('ABCBCDEFEFG')
    expect(Decompressor.decompress('(6x1)(1x3)A')).to eq('(1x3)A')
    expect(Decompressor.decompress('X(8x2)(3x3)ABCY')).to eq('X(3x3)ABC(3x3)ABCY')
  end

  it 'rules all' do
    line_to_decompress = File.readlines('input.txt').first
    puts Decompressor.decompress(line_to_decompress).length
  end
end