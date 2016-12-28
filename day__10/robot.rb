class Robot
  attr_reader :values

  def initialize(id, output, robots)
    @id,@output, @robots = id, output, robots
    @values = []
  end

  def assign_value(val)
    @values << val
    perform_distribution if distribution_to_perform?
  end

  def assign_distribution(distribution)
    @distribution = distribution
    perform_distribution if distribution_to_perform?
  end

  private

  def perform_distribution
    raise ProcessorInterrupt.new(@id) if should_interrupt?

    min = @values.delete(values.min)
    max = @values.delete(values.min)

    assign(@distribution.min_target_id, @distribution.min_target_type, min)
    assign(@distribution.max_target_id, @distribution.max_target_type, max)
  end

  def assign(id, target_type, value)
    return @output[id] =  value if target_type == 'output'

    @robots[id].assign_value(value)
  end

  def distribution_to_perform?
    !@distribution.nil? && @values.size >= 2
  end

  def should_interrupt?
    !@distribution.interrupt_on.nil? && @distribution.interrupt_on.applies_to?(values)
  end
end

class ProcessorInterrupt < Exception
  attr_reader :id
  def initialize(id)
    @id = id
  end
end