class Screen
  attr_reader :display_matrix

  def initialize
    @display_matrix = Array.new(6){Array.new(50, '.')}
  end

  def number_of_lit_pixels
    @display_matrix.flatten.count{|pixel| pixel == '#'}
  end

  def light_up(y,x)
    @display_matrix[y][x] = '#'
  end

  def is_lit_up?(y,x)
    @display_matrix[y][x] == '#'
  end
end







