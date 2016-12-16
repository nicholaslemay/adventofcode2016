require_relative '../draw_rectangle'
require_relative '../screen'

describe DrawRectangle do
  it 'draws a rectangle on the upper left side of the screen' do
    screen = Screen.new

    DrawRectangle.new(3,2).execute(screen)

    expect(screen.number_of_lit_pixels).to eq(6)
    expect(screen.is_lit_up?(0,0)).to eq(true)
    expect(screen.is_lit_up?(1,2)).to eq(true)
    expect(screen.is_lit_up?(2,2)).to eq(false)
  end
end