class VerticalDimensionReader

  def self.read_dimensions_from(filename)
    lines = File.readlines(filename).collect do |line|
      line.strip.split(' ').map(&:to_i)
    end

    lines.transpose.flatten
  end

end