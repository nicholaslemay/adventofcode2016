class RotateColumn
  attr_reader :column, :distance

  def initialize(column, distance)
    @column = column
    @distance = distance
  end

  def execute(screen)
    column  = screen.display_matrix.transpose[@column]
    column.rotate!(-@distance)

    screen.display_matrix.each_with_index do |row, index|
      row[@column] = column[index]
    end
  end

end