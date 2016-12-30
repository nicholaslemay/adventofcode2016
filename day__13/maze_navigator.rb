require_relative 'coordinate'

class MazeNavigator

  def initialize(maze, max_steps_listener=nil)
    @maze = maze
    @max_steps_listener = max_steps_listener
  end

  def shortest_distance_between(start_coordinate, target_coordinate)
    maze = deep_copy(@maze)
    shortest_path(start_coordinate, target_coordinate, maze).size - 1
  end

  private

  def shortest_path(start_coordinate, target_coordinate, maze)
    maze[target_coordinate.x][target_coordinate.y] = 'destination'
    queue = [start_coordinate]

    while queue.size > 0
      coordinate = queue.shift
      return full_path_towards(coordinate) if is_target_node?(maze, coordinate)

      queue += adjacent_path_nodes(coordinate, maze)
      maze[coordinate.x][coordinate.y] = 'explored'

      notify_listener(coordinate, maze)
    end

    raise PathDoesNotExist
  end

  def adjacent_path_nodes(coordinate, maze)
    [  Coordinate.new(coordinate.x-1, coordinate.y, coordinate),
       Coordinate.new(coordinate.x+1, coordinate.y, coordinate),
       Coordinate.new(coordinate.x, coordinate.y-1, coordinate),
       Coordinate.new(coordinate.x, coordinate.y+1, coordinate)
    ].select{|c| is_path_coordinate_within_maze?(c, maze) }
  end

  def is_path_coordinate_within_maze?(c, maze)
    c.is_within_maze?(maze) && (maze[c.x][c.y] == 'open' || is_target_node?(maze, c))
  end

  def full_path_towards(node, previous_nodes=[])
    return previous_nodes if node.nil?
    full_path_towards(node.parent, previous_nodes.unshift(node))
  end

  def is_target_node?(maze, node)
    maze[node.x][node.y] == 'destination'
  end

  def notify_listener(coordinate, maze)
    return unless @max_steps_listener
    nb_explored_locations = maze.flatten.select { |c| c == 'explored' }.size
    nb_steps = full_path_towards(coordinate).size - 1
    @max_steps_listener.nb_explored_locations_in_number_of_steps(nb_explored_locations, nb_steps)
  end

  def deep_copy(maze)
    return Marshal.load(Marshal.dump(maze))
  end
end

class PathDoesNotExist< Exception; end