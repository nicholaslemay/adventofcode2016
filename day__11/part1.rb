require_relative 'cpu'

@cpu = CPU.new
puts 'running...'
@cpu.process_instructions(File.readlines('input.txt'))
puts "Part 1 result #{@cpu.value_of_register(:a)}"
