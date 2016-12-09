require 'digest'

class PasswordEntry
  attr_reader :rank, :value

  @@valid_ranks = ('0'..'7').to_a

  def initialize(door_id, number)
    @is_valid = false

    hash = Digest::MD5.hexdigest "#{door_id}#{number}"
    matches = hash.match(/^0{5}(.)(.)/)

    if matches
      @is_valid =  @@valid_ranks.include?(matches.captures[0])
      @rank = matches.captures[0].to_i
      @value = matches.captures[1]
    end
  end

  def is_valid?
    @is_valid
  end

end