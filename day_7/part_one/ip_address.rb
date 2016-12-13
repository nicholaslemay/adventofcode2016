class IpAddress
  def initialize(complete_address)
    @hyper_sequences = hyper_sequences_from(complete_address)
    @super_net_sequences = sections_outside_hyper_sequences(complete_address)
  end

  def supports_tls?
    @super_net_sequences.any?{|section| contains_abba?(section)} && !@hyper_sequences.any?{|hs|contains_abba?(hs)}
  end

  private

  def contains_abba?(string)
    return false if string.length < 4

    return true if (string[0] != string[1]) && (string[0..1].reverse == string[2..3])
    contains_abba?(string[1..-1])
  end

  def sections_outside_hyper_sequences(complete_address)
    complete_address.gsub(/\[\w+\]/, ',').split(',')
  end

  def hyper_sequences_from(complete_address)
    complete_address.scan(/\[(\w+)\]/).flatten
  end
end


describe IpAddress do

  it 'supports tls when it has an abba outside the hyperlink' do
    expect( IpAddress.new('abba[mnop]qrst').supports_tls?).to eq(true)
    expect( IpAddress.new('ioxxoj[asdfgh]zxcvbn[loetnh]zxcvbn').supports_tls?).to eq(true)
    expect( IpAddress.new('fgfg[asdfgh]zxcvbn[loetnh]ioxxoj').supports_tls?).to eq(true)
  end

  it 'does not support tls when abba is within hyperlink' do
    expect( IpAddress.new('abcd[bddb]xyyx').supports_tls?).to eq(false)
  end

  it 'does not support tls when abba is a repeat of the same char' do
    expect( IpAddress.new('aaaa[qwer]tyui').supports_tls?).to eq(false)
  end

  it 'does not support tls when abba is separated by an hyperlink' do
    expect( IpAddress.new('ab[qwer]ba').supports_tls?).to eq(false)
  end

  it 'solves ze puzzle' do
    addresses = File.readlines('input.txt').map(&:chomp)
    number_of_valid_addresses = 0
    addresses.each{|address| number_of_valid_addresses +=1 if IpAddress.new(address).supports_tls? }
    expect(number_of_valid_addresses).to eq(118)
  end
end