require_relative 'password_entry'

describe PasswordEntry do
  describe 'when the hash of the door id and the number starts with five zeroes' do
    it 'is valid' do
      expect(PasswordEntry.new('abc', 3231929).is_valid?).to eq(true)
    end
    it 'is returns the sixth character of its hash as its value' do
      expect(PasswordEntry.new('abc', 3231929).value).to eq('1')
    end
  end

  describe 'when the hash of the door id and the number doesnot start with zeroes' do
    it 'is valid' do
      expect(PasswordEntry.new('abc', 1).is_valid?).to eq(false)
    end
    it 'is has no value' do
      expect(PasswordEntry.new('abc', 1).value).to eq(nil)
    end
  end
end