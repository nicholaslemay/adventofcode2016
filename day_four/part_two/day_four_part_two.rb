require_relative 'room'

class Day4

  def self.solution_of_part_2
    encrypted_rooms = File.open('input.txt').readlines
    rooms = encrypted_rooms.map { |encrypted| Room.new(encrypted) }
    rooms.find{|r| r.decrypted_name.match(/pole/)}
  end

end
north_pole_room = Day4.solution_of_part_2
puts "#{north_pole_room.decrypted_name} #{north_pole_room.sector_id}"