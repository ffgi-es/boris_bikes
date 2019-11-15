require "docking_station"

describe DockingStation do
  let(:bike) { double(:bike, damaged: nil, working?: true) }
  let(:broken_bike) { double(:bike, damaged: nil, working?: false) }
  let(:bikes) { [bike] * 5 }

  describe "#new" do
    it { is_expected.to have_attributes(capacity: 20) }

    it "should be able to set capacity at initialisation" do
      subject = DockingStation.new 30
      expect(subject).to have_attributes(capacity: 30)
    end
  end

  describe "#release_bike" do
    it "should raise an error if there is no bike" do
      expect{ subject.release_bike }.to raise_error EmptyStationError
    end

    it "should release a working bike" do
      subject.dock_bike bike
      expect(subject.release_bike).to be_working
    end

    it "should remove the bike returned from the station" do
      subject.dock_bike bike
      subject.release_bike
      expect(subject.docked?).to eq false
    end

    it "should store and return multiple bikes" do
      5.times { subject.dock_bike bike }
      5.times { subject.release_bike }
      expect{ subject.release_bike }.to raise_error EmptyStationError
    end

    it "should raise an error if there are no working bikes" do
      subject.dock_bike broken_bike, false
      expect { subject.release_bike }.to raise_error NoWorkingBikesError
    end

    it "should return a working bike regardless of order 1" do
      subject.dock_bike broken_bike, false
      subject.dock_bike bike
      expect(subject.release_bike).to be_working
    end

    it "should return a working bike regardless of order 2" do
      subject.dock_bike bike
      subject.dock_bike broken_bike, false
      expect(subject.release_bike).to be_working
    end

    it "should only return a working bike" do
      subject.dock_bike broken_bike, false
      subject.dock_bike bike
      subject.dock_bike broken_bike, false
      expect(subject.release_bike).to be_working
      expect { subject.release_bike }.to raise_error NoWorkingBikesError
    end
  end

  describe "#dock_bike" do
    it "should accept a bike and store it" do
      subject.dock_bike bike
      expect(subject.release_bike).to eq bike
    end

    it "should raise an error if there is no space" do
      expect{ 
        (DockingStation::DEFAULT_CAPACITY + 1).times { subject.dock_bike(bike) }
      }.to raise_error FullStationError
    end

    it "shouldn't raise an error if the capacity has been changed" do
      station = DockingStation.new 30
      expect { 30.times { station.dock_bike bike } }.to_not raise_error
    end

    it "should print a response if the bike is damaged" do
      message = /Thank you for the report/
      expect { subject.dock_bike broken_bike, false }.to output(message).to_stdout
    end

    it "shouldn't print anything if the bike is fine" do
      expect { subject.dock_bike bike }.to_not output.to_stdout
    end
  end

  describe "#docked?" do
    it "should tell a user if it is empty" do
      expect(subject.docked?).to eq false
    end

    it "should tell a user if it is empty" do
      subject.dock_bike bike
      expect(subject.docked?).to eq true
    end
  end

  describe "#return_bikes" do
    it "should return an empty array if empty" do
      expect(subject.return_bikes).to eq []
    end

    it "should return an empty array if all bikes work" do
      5.times { subject.dock_bike bike }
      expect(subject.return_bikes).to eq []
    end

    it "should return broken bikes" do
      subject.dock_bike bike
      subject.dock_bike broken_bike, false
      subject.dock_bike bike
      subject.dock_bike broken_bike, false
      expect(subject.return_bikes).to eq [broken_bike]*2
    end

    it "should remove the broken bikes" do
      subject.dock_bike broken_bike, false
      subject.dock_bike broken_bike, false
      subject.return_bikes
      expect(subject.docked?).to eq false
    end

    it "should leave any working bikes" do
      subject.dock_bike bike
      subject.dock_bike broken_bike, false
      subject.return_bikes
      expect(subject.docked?).to eq true
    end
  end

  describe "#receive_bikes" do
    it "should accept an array of bike" do
      subject.receive_bikes(bikes)
      expect(subject.docked?).to be true
    end

    it "should make the bikes received available" do
      subject.receive_bikes(bikes)
      expect(subject.release_bike).to eq bike
    end
  end
end
