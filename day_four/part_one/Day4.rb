require_relative 'room'

class Day4

  def self.solution_of_part_1
    encrypted_rooms = File.open('input.txt').readlines
    valid_rooms = encrypted_rooms.map { |encrypted| Room.new(encrypted) }.select { |r| r.is_valid? }
    valid_rooms.inject(0){|sum,r| sum + r.sector_id }
  end
  
end


puts "Part 1: #{Day4.solution_of_part_1}"