require_relative 'processor'
require_relative 'factory'
require_relative 'robot'

describe Processor do

  before(:each) do
    @factory_output = []
    @factory = Factory.new(@factory_output)
    @processor =  Processor.new(@factory)
  end

  it 'assigns values to robots ' do
    @processor.process_instructions(['value 67 goes to bot 187'])
    @processor.process_instructions(['value 89 goes to bot 187'])

    expect(@factory.robots[187].values).to include(67)
    expect(@factory.robots[187].values).to include(89)
  end

  it 'can distributes the value of a robot to other robots' do
    @processor.process_instructions(['value 67 goes to bot 187'])
    @processor.process_instructions(['value 89 goes to bot 187'])
    @processor.process_instructions(['bot 187 gives low to bot 0 and high to bot 1'])

    expect(@factory.robots[187].values).to be_empty
    expect(@factory.robots[0].values).to include(67)
    expect(@factory.robots[1].values).to include(89)
  end

  it 'waits until robot has two values to distribute its value' do
    @processor.process_instructions(['bot 187 gives low to bot 0 and high to bot 1'])
    @processor.process_instructions(['value 67 goes to bot 187'])
    @processor.process_instructions(['value 89 goes to bot 187'])

    expect(@factory.robots[187].values).to be_empty
    expect(@factory.robots[0].values).to include(67)
    expect(@factory.robots[1].values).to include(89)
  end

  it 'can distributes to output and bot' do
    @processor.process_instructions(['value 5 goes to bot 2'])
    @processor.process_instructions(['bot 2 gives low to bot 1 and high to output 15'])
    @processor.process_instructions(['value 3 goes to bot 2'])

    expect(@factory.robots[1].values).to include(3)
    expect(@factory_output[15]).to eq(5)
  end

  it 'interrupts when interrupt condition is met' do
    @processor =  Processor.new(@factory, AnInterrupt.new(2,5))

    @processor.process_instructions(['value 5 goes to bot 2'])
    @processor.process_instructions(['bot 2 gives low to bot 1 and high to bot 0'])
    @processor.process_instructions(['value 3 goes to bot 1'])
    @processor.process_instructions(['bot 1 gives low to output 1 and high to bot 0'])
    @processor.process_instructions(['bot 0 gives low to output 2 and high to output 0'])

    expect{@processor.process_instructions(['value 2 goes to bot 2'])}.to raise_error do |error|
      expect(error).to be_a(ProcessorInterrupt)
      expect(error.id).to eq(2)
    end
  end


  it 'redistributes after a distribution if bot now has two values' do
    @processor = Processor.new(@factory)

    @processor.process_instructions(['value 5 goes to bot 2'])
    @processor.process_instructions(['bot 2 gives low to bot 1 and high to bot 0'])
    @processor.process_instructions(['value 3 goes to bot 1'])
    @processor.process_instructions(['bot 1 gives low to output 1 and high to bot 0'])
    @processor.process_instructions(['bot 0 gives low to output 2 and high to output 0'])
    @processor.process_instructions(['value 2 goes to bot 2'])

    expect(@factory_output[1]).to eq(2)
  end

  it 'solves the part one puzzle' do
    @processor =  Processor.new(@factory, AnInterrupt.new(17,61))

    instructions = File.readlines('input.txt')

    expect{@processor.process_instructions(instructions)}.to raise_error do |error|
      expect(error).to be_a(ProcessorInterrupt)
      expect(error.id).to eq(27)
    end
  end

  it 'solves the part two puzzle' do
    @processor =  Processor.new(@factory)

    instructions = File.readlines('input.txt')
    @processor.process_instructions(instructions)
    result = @factory_output[0] * @factory_output[1] * @factory_output[2]
    expect(result).to eq(13727)

  end
end

AnInterrupt = Struct.new(:val_a,:val_b) do
  def applies_to?(set_of_values)
    set_of_values.include?(val_a) && set_of_values.include?(val_b)
  end
end