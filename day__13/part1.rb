require_relative 'coordinate'
require_relative 'maze_navigator'
require_relative 'maze_generator'


maze = MazeGenerator.new(1358).generate(50,50)
puts 'running'
distance = MazeNavigator.new(maze).shortest_distance_between(Coordinate.new(1,1), Coordinate.new(39,31))
puts distance