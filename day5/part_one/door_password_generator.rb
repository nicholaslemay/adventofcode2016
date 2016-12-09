require_relative 'password_entry'

class DoorPasswordGenerator

  PASSWORD_LENGTH = 8

  def initialize(door_id)
    @door_id = door_id
  end

  def generate
    generated_password = ''
    index = 0

    while(generated_password.length < PASSWORD_LENGTH)
      new_password_entry = PasswordEntry.new(@door_id, index)
      if(new_password_entry.is_valid?)
        generated_password << new_password_entry.value
      end
      index +=1
    end

    generated_password

  end
end