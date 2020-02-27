require 'journey'

describe Journey do

  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

  before(:each) do
    subject.instance_variable_set(:@entry_station, nil)
  end

  describe '#initialize' do
    it "returns an empty array" do
      expect(subject.journeys).to match_array([])
    end
  end

  describe '#add_entry_station' do
    it { is_expected.to respond_to(:add_entry_station).with(1).argument }
    it 'remembers entry_station' do
      subject.add_entry_station entry_station
      subject.instance_variable_get(:@entry_station)
    end
  end

  describe '#add_journey' do
    it { is_expected.to respond_to(:add_journey).with(1).argument  }
    it "returns an array of our journeys" do
      subject.instance_variable_set(:@entry_station, entry_station)
      subject.add_journey exit_station
      expect(subject.journeys).to match_array([{entry: entry_station, exit: exit_station}])
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to (:in_journey?) }
    it 'returns true when journey added' do
      subject.add_entry_station entry_station
      expect(subject).to be_in_journey
    end
  end

  describe '#fare' do
    it { is_expected.to respond_to :fare }
    it 'increases fare by 6 if entry station is added when @entry_station is not nil' do
      subject.instance_variable_set(:@entry_station, entry_station)
      expect { subject.add_entry_station(entry_station) }.to change { subject.fare }.by 6
    end
    it 'increases fare by 6 if journey is added when @entry_station is nil' do
      expect { subject.add_journey(exit_station) }.to change { subject.fare }.by 6
    end
    it 'increases fare by 1 if journey is added when standard journey' do
      subject.add_entry_station(entry_station)
      expect { subject.add_journey(exit_station) }.to change { subject.fare }.by 1
    end
  end
end
