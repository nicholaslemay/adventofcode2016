require_relative 'move'

describe Move do

  it('extract the distance from a move directive') do
    expect(Move.new('R5').distance).to eq(5)
    expect(Move.new('R585').distance).to eq(585)
  end

  it('figures the next direction from a move directive') do
    expect(Move.new('R5').target_direction_after_facing(:north)).to eq(:east)
    expect(Move.new('L5').target_direction_after_facing(:north)).to eq(:west)

    expect(Move.new('R5').target_direction_after_facing(:east)).to eq(:south)
    expect(Move.new('L5').target_direction_after_facing(:east)).to eq(:north)

    expect(Move.new('R5').target_direction_after_facing(:south)).to eq(:west)
    expect(Move.new('L5').target_direction_after_facing(:south)).to eq(:east)

    expect(Move.new('R5').target_direction_after_facing(:west)).to eq(:north)
    expect(Move.new('L5').target_direction_after_facing(:west)).to eq(:south)
  end

  it('can build a series of moves from a series of intentions') do
    expect(Move.built_from('R5, L5, R5, R3').size).to eq(4)
  end
end