require_relative '../screen'

describe Screen do

  before(:each) do
    @screen = Screen.new
  end

  it 'can be lit up' do
    @screen.light_up(0,0)
    @screen.light_up(0,1)

    expect(@screen.number_of_lit_pixels).to eq(2)

    expect(@screen.is_lit_up?(0,0)).to eq(true)
    expect(@screen.is_lit_up?(0,1)).to eq(true)
    expect(@screen.is_lit_up?(1,1)).to eq(false)
  end

end