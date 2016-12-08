require_relative 'room'
describe Room do
  it 'decripts using alphabet shifting' do
    expect(Room.new('qzmt-zixmtkozy-ivhz-343[abcd]').decrypted_name).to eq('very encrypted name')
  end
end