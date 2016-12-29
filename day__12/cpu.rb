class CPU

  def initialize
    @registers = {a: 0, b: 0, c:0, d:0}
  end

  def value_of_register(register)
    @registers[register]
  end

  def process_instructions(instructions)
    instructions << 'FINAL_INSTRUCTION'

    while(instructions.first != 'FINAL_INSTRUCTION')
      instruction_jump = process(instructions.first)
      instructions.rotate!(instruction_jump)
    end

  end

  private

  def process(instruction)
    if instruction =~ /cpy (\d+) (\w+)/
      value = $1.to_i
      register = $2.to_sym
      @registers[register] = value
    elsif instruction =~ /cpy (\w+) (\w+)/
      src_register = $1.to_sym
      target_register = $2.to_sym
      @registers[target_register] = @registers[src_register]
    elsif instruction =~ /inc (\w+)/
      register = $1.to_sym
      @registers[register] += 1
    elsif instruction =~ /dec (\w+)/
      register = $1.to_sym
      @registers[register] -= 1
    elsif instruction =~ /jnz (\w+) (-?\d+)/
      register = $1.to_sym
      return 1 if @registers[register] == 0

      instruction_jump = $2.to_i
      return instruction_jump
    end

    return 1
  end

end