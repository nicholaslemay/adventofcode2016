require_relative 'coordinate'
require_relative 'maze_navigator'
require_relative 'maze_generator'

class AListenerFor50Steps
  attr_reader :nb_explored_locations

  def initialize()
    @nb_explored_locations = []
  end

  def nb_explored_locations_in_number_of_steps(nb_explored_locations, steps)
    @nb_explored_locations << nb_explored_locations if steps == 50
  end
end

listener = AListenerFor50Steps.new
maze = MazeGenerator.new(1358).generate(50,50)
MazeNavigator.new(maze, listener).shortest_distance_between(Coordinate.new(1, 1), Coordinate.new(39, 31))

puts 'running'
puts "#{listener.nb_explored_locations.max}"