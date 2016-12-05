class HqDistanceTracker

  def initialize
    @current_direction = :north
    @x_axis_position = 0
    @y_axis_position = 0
    @visited_coordinates = []
  end

  def distance_from_hq(moves_to_perform)
    move = moves_to_perform.first
    @current_direction = move.target_direction_after_facing(@current_direction)

    1.upto(move.distance) do
      move_forward_in_current_direction
      return current_distance_from_hq if @visited_coordinates.include?(current_coordinates)
      @visited_coordinates << current_coordinates
    end

    distance_from_hq(moves_to_perform.drop(1))
  end

  private

  def current_coordinates
    return [@x_axis_position, @y_axis_position]
  end

  def move_forward_in_current_direction
    @x_axis_position += 1 if (@current_direction == :east)

    @x_axis_position -= 1 if (@current_direction == :west)

    @y_axis_position += 1 if (@current_direction == :north)

    @y_axis_position -= 1 if (@current_direction == :south)
  end

  def current_distance_from_hq
    @y_axis_position.abs + @x_axis_position.abs
  end
end


