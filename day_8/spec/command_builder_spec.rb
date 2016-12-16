require_relative '../command_builder'
require_relative '../rotate_column'
require_relative '../rotate_row'
require_relative '../screen'

describe CommandBuilder do

  it 'can build a rotate row command' do
    command = CommandBuilder.build_command_from('rotate row y=0 by 4')

    expect(command).to be_a(RotateRow)
    expect(command.row).to eq(0)
    expect(command.distance).to eq(4)
  end

  it 'can build a rotate column command' do
    command = CommandBuilder.build_command_from('rotate column x=5 by 6')

    expect(command).to be_a(RotateColumn)
    expect(command.column).to eq(5)
    expect(command.distance).to eq(6)
  end

  it 'can build a draw rectangle command' do
    command = CommandBuilder.build_command_from('rect 3x2')
    expect(command).to be_a(DrawRectangle)
    expect(command.width).to eq(3)
    expect(command.height).to eq(2)
  end
end