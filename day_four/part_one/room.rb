require_relative 'most_frequent_letters'

class Room
  attr_reader :sector_id

  def initialize(encrypted)
    @encrypted_name =  split(encrypted)[0]
    @sector_id =  split(encrypted)[1].to_i
    @checksum =  split(encrypted)[2]
  end

  def is_valid?
    MostFrequentLetters.from(@encrypted_name).take(5).join('') == @checksum
  end

  private

  def split(string)
    string.match(/(.*)-(\d.*)\[(.*)\]/).captures
  end
end