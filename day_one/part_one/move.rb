class Move
  attr_accessor :distance

  def initialize(directive)
    @distance = distance_from(directive)
    @turn = turn_from(directive)
  end

  def self.built_from(directives)
    each_intentions = directives.gsub(/\s+/, '').split(',')
    each_intentions.map{|intention| Move.new(intention)}
  end

  def target_direction_after_facing(current_direction)
    { [:north,:right] => :east,
      [:north,:left] => :west,
      [:south,:left] => :east,
      [:south,:right] => :west,
      [:west,:right] => :north,
      [:west,:left] => :south,
      [:east,:right] => :south,
      [:east,:left] => :north,
    }[[current_direction, @turn]]
  end

  private

  def turn_from(directive)
    directive[0] == 'L' ? :left : :right
  end

  def distance_from(directive)
    directive[1..-1].to_i
  end

end