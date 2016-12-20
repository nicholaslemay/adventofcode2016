require_relative 'decompressor'

describe Decompressor do

  it 'leaves a string sequence without compression marker as is' do
    expect(Decompressor.decompressed_length('ADVENT')).to eq(6)
  end

  it 'repeats the number of letter for the number of times in the marker' do
    expect(Decompressor.decompressed_length('(3x3)XYZ')).to eq(9)

    expect(Decompressor.decompressed_length('X(8x2)(3x3)ABCY')).to eq(20)
    expect(Decompressor.decompressed_length('(13x10)(7x10)(1x10)A')).to eq(1000)
    expect(Decompressor.decompressed_length('(7x2)(1x2)AB')).to eq(6)
    expect(Decompressor.decompressed_length('(27x12)(20x12)(13x14)(7x10)(1x12)A')).to eq(241920)
    expect(Decompressor.decompressed_length('(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN')).to eq(445)
  end

  it 'crashes and burns' do
    expect(Decompressor.decompressed_length(File.readlines('input.txt')[0])).to eq(10780403063)
  end

end