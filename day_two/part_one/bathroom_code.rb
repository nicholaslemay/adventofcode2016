Coordinates = Struct.new(:y, :x)

class BathroomCode
  @@keypad = [
      %w(1 2 3),
      %w(4 5 6),
      %w(7 8 9),
  ]

  def initialize
    @current_location = Coordinates.new(1, 1)
  end

  def from_instructions(instruction_series)
    code = ''

    instruction_series.each do |instructions|
      instructions.split('').each{ |instruction| perform(instruction)}
      code << keypad_value_at_current_location
    end

    code
  end

  def keypad_value_at_current_location
    @@keypad[@current_location.y][@current_location.x]
  end

  def perform(instruction)
    @current_location.y -= 1 if instruction == 'U' && @current_location.y != 0
    @current_location.y += 1 if instruction == 'D' && @current_location.y != 2
    @current_location.x -= 1 if instruction == 'L' && @current_location.x != 0
    @current_location.x += 1 if instruction == 'R' && @current_location.x != 2
  end
end
