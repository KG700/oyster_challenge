require 'station'

describe Station do 
 
    subject { Station.new(name,zone)}

    let(:name) { "barbican" }
    let(:zone) { "1" }

    it 'exposes the name of the station and the zone' do 
        # @name = "barbican"
        # @zone = "1"
        expect(subject).to respond_to :name 
        expect(subject).to respond_to :zone
    end 
    it 'checks the values in station' do
       expect(subject.name).to eq "barbican"
       expect(subject.zone).to eq "1"
    end

end 