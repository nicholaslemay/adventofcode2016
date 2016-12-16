class DrawRectangle
  attr_reader :width, :height
  def initialize(width, height)
    @width = width
    @height = height
  end

  def execute(screen)
    (0...height).to_a.each do |row|
      (0...width).to_a.each do |column|
        screen.light_up(row, column)
      end
    end
  end
end