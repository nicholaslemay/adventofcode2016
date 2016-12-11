class MessageFromSignals
  def self.from_signals(signals)
    signals_as_char_arrays = signals.map{|s| s.split('')}

    chars_by_positions = signals_as_char_arrays.transpose
    most_frequent_char_by_position = chars_by_positions.collect{|chars| most_frequent_letter(chars)}
    most_frequent_char_by_position.join('')
  end

  def self.most_frequent_letter(letters)
    grouped_letters = letters.group_by { |letter| letter }.values
    grouped_letters.sort_by{|grouped_letter| [-grouped_letter.count]}.flatten.uniq.first
  end
end


describe MessageFromSignals do

  it 'decodes message from signals using the most frequent letter per position' do
   signals = %w( eedadn drvtee eandsr raavrd atevrs tsrnev sdttsa rasrtv nssdts ntnada svetve tesnvt vntsnd vrdear dvrsen enarar)
   expect(MessageFromSignals.from_signals(signals)).to eq('easter')
  end

  it 'solves the riddle' do
    signals = File.readlines('input.txt').map(&:chomp)
    expect(MessageFromSignals.from_signals(signals)).to eq('mshjnduc')
  end
end