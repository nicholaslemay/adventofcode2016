require_relative '../draw_rectangle'
require_relative '../rotate_column'
require_relative '../screen'

describe RotateColumn do
  it 'rotate a row to the right' do
    screen = Screen.new

    DrawRectangle.new(3,2).execute(screen)
    RotateColumn.new(0,2).execute(screen)

    expect(screen.number_of_lit_pixels).to eq(6)
    expect(screen.is_lit_up?(0,0)).to eq(false)
    expect(screen.is_lit_up?(1,0)).to eq(false)
    expect(screen.is_lit_up?(2,0)).to eq(true)
    expect(screen.is_lit_up?(3,0)).to eq(true)
    expect(screen.is_lit_up?(4,0)).to eq(false)
    expect(screen.is_lit_up?(5,0)).to eq(false)
  end
end
