class MostFrequentLetters
  @@alphabet = ('a'..'z').to_a

  def self.from(string)
    sort_by_count_then_alphabetically(letters_from(string))
  end

  def self.sort_by_count_then_alphabetically(letters)
    grouped_letters = letters.group_by { |letter| letter }.values
    grouped_letters.sort_by{|grouped_letter| [-grouped_letter.count, grouped_letter.first]}.flatten.uniq
  end

  def self.letters_from(string)
    string.split('').select { |c| @@alphabet.include?(c) }
  end
end