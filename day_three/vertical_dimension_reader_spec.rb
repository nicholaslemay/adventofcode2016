require_relative 'vertical_dimension_reader'

describe VerticalDimensionReader do
  it 'reads a dimensions file vertically' do
    dimensions = VerticalDimensionReader.read_dimensions_from('sample.txt')
    expect(dimensions[0]).to eq(883)
    expect(dimensions[1]).to eq(572)
    expect(dimensions[2]).to eq(842)
  end
end
