class IpAddress
  def initialize(complete_address)
    @hyper_sequences = hyper_sequences_from(complete_address)
    @super_net_sequences = super_net_sequences(complete_address)
  end

  def supports_ssl?
    @super_net_sequences.any?{|sequence| has_aba_with_corresponding_bab?(sequence)}
  end

  private

  def has_aba_with_corresponding_bab?(sequence)
    return false if sequence.length < 3

    next_3_chars = sequence[0..2]

    return true if(is_aba?(next_3_chars) && has_aba_in_hyper_sequences?(next_3_chars))

    has_aba_with_corresponding_bab?(sequence[1..-1])
  end

  def has_aba_in_hyper_sequences?(next_3_chars)
    @hyper_sequences.any? { |h| h.include?(bab_from(next_3_chars)) }
  end

  def is_aba?(string)
    !all_equal_characters?(string) && string[0] == string[2]
  end

  def bab_from(string)
    string[1] + string[0] + string[1]
  end

  def all_equal_characters?(string)
    string.split('').uniq.length == 1
  end

  def super_net_sequences(complete_address)
    complete_address.gsub(/\[\w+\]/, ',').split(',')
  end

  def hyper_sequences_from(complete_address)
    complete_address.scan(/\[(\w+)\]/).flatten
  end
end


describe IpAddress do

  it 'supports ssl when super net aba has corresponding bab in hyper sequence' do
    expect( IpAddress.new('aba[bab]xyz').supports_ssl?).to eq(true)
    expect( IpAddress.new('aaa[kek]eke').supports_ssl?).to eq(true)
    expect( IpAddress.new('zazbz[bzb]cdb').supports_ssl?).to eq(true)
  end

  it 'does not support ssl when super net aba has no bab in hyper sequences' do
    expect( IpAddress.new('xyx[xyx]xyx').supports_ssl?).to eq(false)
  end

  it 'solves ze puzzle' do
    addresses = File.readlines('input.txt').map(&:chomp)
    number_of_valid_addresses = 0
    addresses.each{|address| number_of_valid_addresses +=1 if IpAddress.new(address).supports_ssl? }
    expect(number_of_valid_addresses).to eq(260)
  end
end