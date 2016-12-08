require_relative 'triangle_validator'
require_relative 'vertical_dimension_reader'

describe TriangleValidator do

  it 'is valid if any two sides is larger than the remaining one' do
    expect(TriangleValidator.new(5,5,5).is_valid?).to eq(true)
  end

  it 'is invalid if c is less than a + b ' do
    expect(TriangleValidator.new(5,5,25).is_valid?).to eq(false)
  end

  it 'is invalid if b is less than a + c' do
    expect(TriangleValidator.new(5,25,5).is_valid?).to eq(false)
  end

  it 'is invalid if a is less than b + c' do
    expect(TriangleValidator.new(25,5,5).is_valid?).to eq(false)
  end

  it('helps solve a puzzle') do
    valid_triangles = 0
    File.readlines('sample.txt').each do |line|
      side_a, side_b, side_c = line.strip.split(' ').map(&:to_i)

      triangle = TriangleValidator.new(side_a, side_b, side_c)
      valid_triangles +=1 if triangle.is_valid?
    end
    expect(valid_triangles).to eq(982)
  end

  it('helps solve the second puzzle') do
    valid_triangles = 0

    dimensions = VerticalDimensionReader.read_dimensions_from('sample.txt')

    dimensions.each_slice(3) {|side_a, side_b, side_c|
      valid_triangles += 1 if TriangleValidator.new(side_a,side_b,side_c).is_valid?
    }
    expect(valid_triangles).to eq(1826)
  end
end