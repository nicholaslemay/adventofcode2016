Distribution = Struct.new(:min_target_id, :min_target_type, :max_target_id, :max_target_type,:interrupt_on)

class Processor

  def initialize(factory, interrupt_on = nil)
    @factory = factory
    @interrupt_on = interrupt_on
  end

  def process_instructions(raw_instructions)
    raw_instructions.each{|i|process_instruction(i)}
  end

  def process_instruction(instruction)
    if instruction =~ /goes to bot/
      perform_assignment(instruction)
    else
      assign_distribution(instruction)
    end
  end

  private
  def assign_distribution(instruction)
    id, min_type, min_id, max_type, max_id = instruction.match(/bot (\d*) gives low to (\w+) (\d*) and high to (\w+) (\d*)/).captures
    id, min_id, max_id = [id, min_id, max_id].map(&:to_i)

    @factory.create_robots(id, min_id, max_id)

    distribution = Distribution.new(min_id, min_type, max_id, max_type, @interrupt_on)
    @factory.robots[id].assign_distribution(distribution)
  end

  def perform_assignment(instruction)
    value, id = instruction.match(/value (\d*) goes to bot (\d*)/).captures.map(&:to_i)
    @factory.create_robot(id)
    @factory.robots[id].assign_value(value)
  end

end