require_relative 'cpu'

describe CPU do

  before(:each) do
    @cpu = CPU.new
  end

  it 'has four registers that start at value 0' do
    expect(@cpu.value_of_register(:a)).to eq(0)
    expect(@cpu.value_of_register(:b)).to eq(0)
    expect(@cpu.value_of_register(:c)).to eq(0)
    expect(@cpu.value_of_register(:d)).to eq(0)
  end

  it 'can assign a value to a registry' do
    @cpu.process_instructions(['cpy 41 c'])

    expect(@cpu.value_of_register(:c)).to eq(41)
  end

  it 'can assign a value from a registry to another' do
    @cpu.process_instructions(['cpy 41 c'])
    @cpu.process_instructions(['cpy c a'])

    expect(@cpu.value_of_register(:a)).to eq(41)
  end

  it 'can increment a value from a registry' do
    @cpu.process_instructions(['cpy 41 c'])
    @cpu.process_instructions(['inc c'])

    expect(@cpu.value_of_register(:c)).to eq(42)
  end

  it 'can decrement a value from a registry' do
    @cpu.process_instructions(['cpy 41 c'])
    @cpu.process_instructions(['dec c'])

    expect(@cpu.value_of_register(:c)).to eq(40)
  end

  it 'jumps instructions when value of associated registry is not 0' do
    @cpu.process_instructions(['cpy 41 a','jnz a 2','inc a'])

    expect(@cpu.value_of_register(:a)).to eq(41)
  end

  it 'does not jump instructions when value of associated registry is not 0' do
    @cpu.process_instructions(['cpy 41 a','jnz c 2','inc a'])

    expect(@cpu.value_of_register(:a)).to eq(42)
  end

  it 'can jump backward as long as the assosiated registry has a value' do
    @cpu.process_instructions(['cpy 41 a',
                               'cpy 3 b',
                               'dec a',
                               'dec b',
                               'jnz b -2',
                              ])

    expect(@cpu.value_of_register(:a)).to eq(38)
  end
end