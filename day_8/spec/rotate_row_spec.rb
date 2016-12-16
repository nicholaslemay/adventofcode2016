require_relative '../draw_rectangle'
require_relative '../rotate_row'
require_relative '../screen'

describe RotateRow do
  it 'rotate a row to the right' do
    screen = Screen.new

    DrawRectangle.new(3,2).execute(screen)
    RotateRow.new(0,1).execute(screen)

    expect(screen.number_of_lit_pixels).to eq(6)

    expect(screen.is_lit_up?(0,1)).to eq(true)
    expect(screen.is_lit_up?(0,0)).to eq(false)
    expect(screen.is_lit_up?(0,2)).to eq(true)
    expect(screen.is_lit_up?(0,3)).to eq(true)
  end

  it 'rotate a row to the right and cycles element being pushed off' do
    screen = Screen.new

    DrawRectangle.new(3,2).execute(screen)
    RotateRow.new(0,49).execute(screen)

    expect(screen.number_of_lit_pixels).to eq(6)
    expect(screen.is_lit_up?(0,48)).to eq(false)
    expect(screen.is_lit_up?(0,49)).to eq(true)
    expect(screen.is_lit_up?(0,0)).to eq(true)
    expect(screen.is_lit_up?(0,1)).to eq(true)
    expect(screen.is_lit_up?(0,2)).to eq(false)
  end
end
