require_relative 'password_entry'

class DoorPasswordGenerator

  def initialize(door_id)
    @door_id = door_id
  end

  def generate
    generated_password = '        '
    index = 0

    while(has_missing_chars?(generated_password))
      new_password_entry = PasswordEntry.new(@door_id, index)
      if(new_password_entry.is_valid? && generated_password[new_password_entry.rank] == ' ')
        generated_password[new_password_entry.rank] = new_password_entry.value
      end
      index +=1
    end

    generated_password
  end

  private

  def has_missing_chars?(generated_password)
    generated_password.match(/\s/)
  end
end