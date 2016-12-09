require 'digest'

class PasswordEntry

  def initialize(door_id, number)
    @hash = Digest::MD5.hexdigest "#{door_id}#{number}"
  end

  def is_valid?
    !!(@hash =~ /^00000/)
  end

  def value
    return nil unless is_valid?
    @hash.match(/^00000(.)/).captures[0]
  end
end