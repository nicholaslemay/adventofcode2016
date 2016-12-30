require_relative 'maze_generator'


describe MazeGenerator do

  it 'can generate the maze from the website' do
    expect(MazeGenerator.new(10).generate(7, 10)).to eq(website_map())
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