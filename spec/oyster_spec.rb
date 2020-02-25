require 'oyster'

describe OysterCard do

# In order to use public transport
# As a customer
# I want money on my card
  it 'shows me my default balance' do
      expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'can top up the balance' do
    expect{ subject.top_up 1}.to change{ subject.balance }.by 1
  end

  it "will fail if you try and top up past the maximum balance allowed, #{OysterCard::MAXIMUM_BALANCE}" do
    expect{subject.top_up(91)}.to raise_error "You cant top up more than #{OysterCard::MAXIMUM_BALANCE} balance"
  end

  it { is_expected.to respond_to(:deduct).with(1).argument }

  it 'will deduct the amount from the oyster card' do
  expect{subject.deduct(2) }.to change{subject.balance }.by -2
  end

  # This test is to check the response of touchin method.

  it { is_expected.to respond_to(:touch_in) } 
  
  it 'check if the oyster card have been touch in' do 
    expect(subject.touch_in).to eq true
  end

  # This tests are for test in_journey? method.

  it { is_expected.to respond_to(:in_journey?) }

  it 'expect the travel to be when the touch in has been done.' do
    allow(subject).to receive(:touch_in) { true }
    expect(subject.in_journey?).to eq true

end 

  # This tests are for testing touch_out method.

  it { is_expected.to respond_to(:touch_out)}

end
