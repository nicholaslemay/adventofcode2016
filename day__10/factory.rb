class Factory
  attr_reader :robots

  def initialize(output)
    @robots = {}
    @output = output
  end

  def create_robots(*ids)
    ids.each{|id| create_robot(id)}
  end

  def create_robot(id)
    @robots[id] ||= Robot.new(id, @output, @robots)
  end
end