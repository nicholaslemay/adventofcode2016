class HqDistanceTracker

  def initialize
    @current_direction = :north
    @x_axis_position = 0
    @y_axis_position = 0
  end

  def distance_after(moves_to_perform)
    return current_distance_from_hq if moves_to_perform.empty?
    perform_move(moves_to_perform.first)
    distance_after(moves_to_perform.drop(1))
  end

  def perform_move(move)
    @current_direction = move.target_direction_after_facing(@current_direction)
    move_in_current_direction(move.distance)
  end

  def move_in_current_direction(distance)
    @x_axis_position += distance if (@current_direction == :east)

    @x_axis_position -= distance if (@current_direction == :west)

    @y_axis_position += distance if @current_direction == :north

    @y_axis_position -= distance if (@current_direction == :south)
  end

  def current_distance_from_hq
    @y_axis_position.abs + @x_axis_position.abs
  end
end
