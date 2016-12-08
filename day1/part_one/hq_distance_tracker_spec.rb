require_relative 'move'
require_relative 'hq_distance_tracker'

describe HqDistanceTracker do

  it 'start with a distance of 0' do
    expect(HqDistanceTracker.new().distance_after([])).to eq(0)
  end

  it 'has a distance equal to the distance of a single move' do
    moves_to_perform = Move.built_from('R5')
    expect(HqDistanceTracker.new().distance_after(moves_to_perform)).to eq(5)
    moves_to_perform = Move.built_from('L5')
    expect(HqDistanceTracker.new().distance_after(moves_to_perform)).to eq(5)
  end

  it 'can perform two consecutive moves' do
    moves_to_perform = Move.built_from('R2, L3')
    expect(HqDistanceTracker.new().distance_after(moves_to_perform)).to eq(5)
  end

  it 'takes into account turning when doing multiple right moves' do
    moves_to_perform = Move.built_from('R2, R2, R2')
    expect(HqDistanceTracker.new().distance_after(moves_to_perform)).to eq(2)
  end

  it 'takes into account turning when doing multiple left moves' do
    moves_to_perform = Move.built_from('L2, L2, L2')
    expect(HqDistanceTracker.new().distance_after(moves_to_perform)).to eq(2)
  end

  it 'can mix and match left and right turns' do
    moves_to_perform = Move.built_from('R5, L5, R5, R3')
    expect(HqDistanceTracker.new().distance_after(moves_to_perform)).to eq(12)
  end

  it 'can resolve the puzzle' do
    moves_to_perform = Move.built_from('R4, R3, L3, L2, L1, R1, L1, R2, R3, L5, L5, R4, L4, R2, R4, L3, R3, L3, R3, R4, R2, L1, R2, L3, L2, L1, R3, R5, L1, L4, R2, L4, R3, R1, R2, L5, R2, L189, R5, L5, R52, R3, L1, R4, R5, R1, R4, L1, L3, R2, L2, L3, R4, R3, L2, L5, R4, R5, L2, R2, L1, L3, R3, L4, R4, R5, L1, L1, R3, L5, L2, R76, R2, R2, L1, L3, R189, L3, L4, L1, L3, R5, R4, L1, R1, L1, L1, R2, L4, R2, L5, L5, L5, R2, L4, L5, R4, R4, R5, L5, R3, L1, L3, L1, L1, L3, L4, R5, L3, R5, R3, R3, L5, L5, R3, R4, L3, R3, R1, R3, R2, R2, L1, R1, L3, L3, L3, L1, R2, L1, R4, R4, L1, L1, R3, R3, R4, R1, L5, L2, R2, R3, R2, L3, R4, L5, R1, R4, R5, R4, L4, R1, L3, R1, R3, L2, L3, R1, L2, R3, L3, L1, L3, R4, L4, L5, R3, R5, R4, R1, L2, R3, R5, L5, L4, L1, L1')
    expect(HqDistanceTracker.new().distance_after(moves_to_perform)).to eq(288)
  end

end