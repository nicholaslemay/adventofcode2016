class RotateRow

  attr_reader :row, :distance

  def initialize(row, distance)
    @row = row
    @distance = distance
  end

  def execute(screen)
    screen.display_matrix[@row].rotate!(-@distance)
  end

end
