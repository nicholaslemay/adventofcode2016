require_relative 'door_password_generator'

describe DoorPasswordGenerator do
  it 'generates a password based on door id' do
    expect(DoorPasswordGenerator.new('abc').generate).to eq('18f47a30')
  end
end