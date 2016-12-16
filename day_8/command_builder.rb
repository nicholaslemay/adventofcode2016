require_relative 'draw_rectangle'
require_relative 'rotate_column'
require_relative 'rotate_row'

class CommandBuilder
  def self.build_command_from(instruction)
    case instruction
      when /rect/
        return build_draw_rectangle_command_from(instruction)
      when /row/
        return build_rotate_row_command_from(instruction)
      when /column/
        return build_rotate_column_command_from(instruction)
    end
  end

  private

  def self.build_draw_rectangle_command_from(instruction)
    width, height = instruction.match(/(\d*)x(\d*)/).captures.map(&:to_i)
    DrawRectangle.new(width, height)
  end

  def self.build_rotate_row_command_from(instruction)
    column, distance = instruction.match(/y=(\d*) by (\d*)/).captures.map(&:to_i)
    RotateRow.new(column, distance)
  end

  def self.build_rotate_column_command_from(instruction)
    column, distance = instruction.match(/x=(\d*) by (\d*)/).captures.map(&:to_i)
    RotateColumn.new(column, distance)
  end
end