Coordinate = Struct.new(:x,:y,:parent) do
  def is_within_maze?(map)
    max_x = map.size
    max_y = map[0].size
    x >= 0 && y >= 0 && x < max_x && y < max_y
  end
end