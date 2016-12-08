Coordinates = Struct.new(:y, :x)

class BathroomCode
  @@keypad = [
      %w(* * * * * * *),
      %w(* * * 1 * * *),
      %w(* * 2 3 4 * *),
      %w(* 5 6 7 8 9 *),
      %w(* * A B C * *),
      %w(* * * D * * *),
      %w(* * * * * * *),
  ]

  def initialize
    @current_location = Coordinates.new(3, 1)
  end

  def from_instructions(instruction_series)
    code = ''

    instruction_series.each do |instructions|
      instructions.split('').each{ |instruction| perform(instruction)}
      code << value_at(@current_location)
    end

    code
  end

  def perform(instruction)
    target = target_location_from(instruction)
    @current_location = target if is_valid?(target)
  end

  def target_location_from(instruction)
    target = Coordinates.new(@current_location.y, @current_location.x)

    target.y -= 1 if instruction == 'U'
    target.y += 1 if instruction == 'D'
    target.x -= 1 if instruction == 'L'
    target.x += 1 if instruction == 'R'
    target
  end

  def is_valid?(location)
    value_at(location) != '*'
  end

  def value_at(location)
    @@keypad[location.y][location.x]
  end
end
