require_relative 'cpu'

@cpu = CPU.new
puts 'running...'
@cpu.process_instructions(['cpy 1 c'])
@cpu.process_instructions(File.readlines('input.txt'))
puts "Part 2 result #{@cpu.value_of_register(:a)}"
