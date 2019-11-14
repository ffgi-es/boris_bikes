require 'van'

describe Van do
  let(:broken_bikes) { [double(:broken_bike, working?: false)] * 5 }
  let(:fixed_bikes) { [double(:fixed_bike, working?: true)] * 5 }
  let(:empty_storage) { spy(:storage, return_bikes: [], receive_bikes: nil) }
  let(:docking_station) { spy(:station, return_bikes: broken_bikes, receive_bikes: nil) }
  let(:garage) { spy(:garage, return_bikes: fixed_bikes, receive_bikes: nil) }

  describe "#collect_from" do
    it "should ask storage for bikes to be returned" do
      subject.collect_from empty_storage
      expect(empty_storage).to have_received(:return_bikes)
    end
  end

  describe "#deliver_to" do
    it "should give the bikes to the garage or docking_station" do
      subject.collect_from docking_station
      subject.deliver_to garage
      expect(garage).to have_received(:receive_bikes).with(broken_bikes)
    end
  end
end
