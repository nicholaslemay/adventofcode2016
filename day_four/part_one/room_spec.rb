require_relative 'room'

describe Room do

  it 'shares its sector id' do
    expect(Room.new('aaaaa-bbb-z-y-x-123[abxyz]').sector_id).to eq(123)
  end

  it 'validates the encrypted name against its checksum' do
    expect(Room.new('aaaaa-bbb-z-y-x-123[abxyz]').is_valid?).to eq(true)
    expect(Room.new('a-b-c-d-e-f-g-h-987[abcde]').is_valid?).to eq(true)
    expect(Room.new('not-a-real-room-404[oarel]').is_valid?).to eq(true)
    expect(Room.new('totally-real-room-200[decoy]').is_valid?).to eq(false)
  end
end