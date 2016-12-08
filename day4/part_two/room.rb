class Room

  def initialize(encrypted)
    @encrypted_name =  split(encrypted)[0]

    @number_of_shifts =  split(encrypted)[1].to_i

    @alphabet = ('a'..'z').to_a
  end

  def sector_id
    @number_of_shifts
  end

  def decrypted_name
    @encrypted_name.split('').map{|c| shift_letter_by_number_of_shifts(c)}.join
  end

  private

  def shift_letter_by_number_of_shifts(char)
    return ' ' if char == '-'

    char_rank = @alphabet.index(char)
    @alphabet[(char_rank + @number_of_shifts) % 26]
  end

  def split(string)
    string.match(/(.*)-(\d.*)\[(.*)\]/).captures
  end

end





