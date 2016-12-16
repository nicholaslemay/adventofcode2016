require_relative 'screen'
require_relative 'command_builder'

class Day8Puzzle

  def self.solve
    screen = Screen.new
    instructions = File.readlines('input.txt')

    instructions.each do |instruction|
      command = CommandBuilder.build_command_from(instruction)
      command.execute(screen)
    end

    puts 'Number of lit pixels: ', screen.number_of_lit_pixels
    screen.display_matrix.each{|row| puts "#{row}"}
  end

end

Day8Puzzle.solve