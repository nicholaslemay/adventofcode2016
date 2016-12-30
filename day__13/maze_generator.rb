class MazeGenerator
  def initialize(seed)
    @seed = seed
  end

  def generate(height, width)
    maze = []
    (0...height).to_a.each do |y|
      maze << []
      (0...width).to_a.each do |x|
        maze[y] << value_for(x,y)
      end
    end
    maze
  end

  private

  def value_for(x,y)
    value = x*x + 3*x + 2*x*y + y + y*y
    value += @seed
    binary_value = value.to_s(2)

    is_odd = (binary_value.count('1') % 2) == 0
    is_odd ? 'open' : 'wall'
  end
end
