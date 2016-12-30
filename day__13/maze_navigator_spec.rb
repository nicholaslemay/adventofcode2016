require_relative 'maze_navigator'
require_relative 'coordinate'

describe MazeNavigator do

  it 'throws an exception when path cannot be resolved' do
    map = [
        %w(wall open wall),
        %w(wall wall wall),
        %w(wall open wall),
    ]

    expect{
      MazeNavigator.new(map).shortest_distance_between(Coordinate.new(0,1), Coordinate.new(2,1))
    }.to raise_error(PathDoesNotExist)
  end

  it 'return 0 when source and destination are the same' do
    map = [ %w(wall open wall)]
    distance = MazeNavigator.new(map).shortest_distance_between(Coordinate.new(0, 1), Coordinate.new(0, 1))
    expect(distance).to eq(0)
  end

  it 'returns the smallest of path when many paths are possible' do
    map = [
        %w(open open open),
        %w(open open open),
        %w(open open open),
    ]
    distance = MazeNavigator.new(map).shortest_distance_between(Coordinate.new(0, 1), Coordinate.new(2, 1))
    expect(distance).to eq(2)
  end


  it 'can resolve a path along the boundaries without getting out of bounds' do
    map = [
        %w(open open open),
        %w(wall wall open),
        %w(open open open),
        %w(open wall wall),
    ]
    distance = MazeNavigator.new(map).shortest_distance_between(Coordinate.new(0, 0), Coordinate.new(3, 0))
    expect(distance).to eq(7)
  end

  it 'can solve the example from the website' do
    expect(MazeNavigator.new(website_map()).shortest_distance_between(Coordinate.new(1,1), Coordinate.new(4,7))).to eq(11)
  end

  it 'leaves the map unchanged' do
    map = website_map()
    MazeNavigator.new(map).shortest_distance_between(Coordinate.new(1,1), Coordinate.new(4,7))

    expect(map).to eq(website_map)
  end

  def website_map
    return [
        %w(open wall open wall wall wall wall open wall wall),
        %w(open open wall open open wall open open open wall),
        %w(wall open open open open wall wall open open open),
        %w(wall wall wall open wall open wall wall wall open),
        %w(open wall wall open open wall open open wall open),
        %w(open open wall wall open open open open wall open),
        %w(wall open open open wall wall open wall wall wall),
    ]
  end

end

