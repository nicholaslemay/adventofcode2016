Marker = Struct.new(:length, :nb_chars_to_repeat, :times_to_repeat)

class Decompressor

  def self.decompressed_length(sequence)
    size = 0

    while (!sequence.empty?) do
      marker = marker_from_start_of(sequence)
      size += number_of_chars_to_add_from(marker, sequence)
      sequence = new_sequence_after_processing(marker, sequence)
    end

    size
  end

  private

  def self.number_of_chars_to_add_from(marker, sequence)
    return 1 unless marker

    sequence_affected_by_marker = sequence[marker.length...(marker.length + marker.nb_chars_to_repeat)]
    nb_chars_to_repeat  = decompressed_length(sequence_affected_by_marker)
    marker.times_to_repeat * nb_chars_to_repeat
  end

  def self.new_sequence_after_processing(marker,sequence)
    return sequence[1..-1] unless (marker)
    sequence[marker.length + marker.nb_chars_to_repeat..-1]
  end

  def self.marker_from_start_of(string)
    return nil unless string =~ /^(\((\d*)x(\d*)\))/
    Marker.new($1.length, $2.to_i, $3.to_i)
  end

end
