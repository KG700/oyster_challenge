require 'oyster'

describe Oystercard do

let(:entry_station) {double :entry_station}
let(:exit_station) {double :exit_station}

before(:each) do
  subject.instance_variable_set(:@balance, 10)
end

  describe '#initialize' do
    it 'shows me my default balance' do
        subject.instance_variable_defined?(:@balance)
    end
    it "returns an empty array" do
      expect(subject.journeys).to match_array([])
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it 'can top up the balance' do
      expect{ subject.top_up 1}.to change{ subject.balance }.by 1
    end
    it "will fail if you try and top up past the maximum balance allowed, #{Oystercard::MAXIMUM_BALANCE}" do
      expect{subject.top_up(91)}.to raise_error "You cant top up more than #{Oystercard::MAXIMUM_BALANCE} balance"
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }
    it 'start the journey' do
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
    it "if mimimum amount is less than £1 you cannot travel" do
      subject.instance_variable_set(:@balance, 0)
      expect{ subject.touch_in(entry_station) }.to raise_error "You cannot travel as you have less than £#{Oystercard::MINIMUM_FARE}"
    end
    it 'remembers entry station' do
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

  end

  describe '#journeys' do
    it { is_expected.to respond_to(:in_journey?) }
    it "journeys to return an array of our journeys" do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to match_array([{entry: entry_station, exit: exit_station}])
    end

  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out)}

    it 'updates in in_journey to false' do
      subject.touch_in entry_station
      subject.touch_out exit_station
      expect(subject.in_journey?).to eq(false)
    end

    it 'will deduct the amount from the oyster card' do
      expect{ subject.touch_out exit_station }.to change{subject.balance }.by -1
    end

    it 'will converte entry_station to nil' do
      subject.touch_in entry_station
      subject.touch_out exit_station
      expect(subject.entry_station).to eq nil
    end

  end

end
