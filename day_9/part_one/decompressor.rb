Marker = Struct.new(:length, :number_of_chars_to_repeat, :number_of_times_to_repeat)

class Decompressor

  def self.decompress(string, decompressed_result = '')
    return decompressed_result << string unless contains_marker?(string)

    marker = marker_from_start_of(string)

    if(marker.nil?)
      return self.decompress(string[1..-1], decompressed_result << string[0])
    end

    decompressed_rest_of_string_with_marker_applied(decompressed_result, marker, string)
  end

  def self.decompressed_rest_of_string_with_marker_applied(decompressed_result, marker, string)
    string_without_marker = string[marker.length..-1]
    repeated_sequence = repeated_sequence(marker, string_without_marker)
    self.decompress(string_without_marker[marker.number_of_chars_to_repeat..-1], decompressed_result << repeated_sequence)
  end

  private

  def self.repeated_sequence(marker, string)
    string[0...marker.number_of_chars_to_repeat] * marker.number_of_times_to_repeat
  end

  def self.contains_marker?(string)
    string =~ /\(\d*x\d*\)/
  end

  def self.marker_from_start_of(string)
    return nil unless string =~ /^(\((\d*)x(\d*)\))/
    Marker.new($1.length, $2.to_i, $3.to_i)
  end
end
