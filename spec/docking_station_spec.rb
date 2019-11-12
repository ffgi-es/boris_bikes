require "docking_station"

describe DockingStation do
  subject {described_class.new}   

  it "should exist"  do
    expect(subject).to be_instance_of DockingStation
  end

  it {is_expected.to respond_to :release_bike}
  
  describe "#release_bike" do
    it "should return a Bike if there is one docked" do
      subject.dock_bike Bike.new
      expect(subject.release_bike).to be_instance_of Bike
    end

    it "should raise an error if there is no bike" do
      expect{ subject.release_bike }.to raise_error EmptyStationError
    end

    it "should release a working bike" do
      subject.dock_bike Bike.new
      bike = subject.release_bike
      expect(bike.working?).to eq true
    end

    it "should remove the bike returned from the station" do
      subject.dock_bike Bike.new
      subject.release_bike
      expect(subject.docked?).to eq false
    end

    it "should store and return multiple bikes" do
      5.times { subject.dock_bike Bike.new }
      5.times { subject.release_bike }
      expect{ subject.release_bike }.to raise_error EmptyStationError
    end
  end

  it { is_expected.to respond_to :dock_bike }

  describe "#dock_bike" do
    it "should accept a Bike and store it" do
      bike = Bike.new
      subject.dock_bike bike
      expect(subject.bikes.first).to eq bike
    end

    it "should raise an error if there is no space" do
      expect{ 21.times { subject.dock_bike(Bike.new) } }.to raise_error FullStationError
    end
  end

  it { is_expected.to have_attributes(bikes: []) }
  it { is_expected.to respond_to(:docked?) }

  describe "#docked?" do
    it "should tell a user if it is empty" do
      expect(subject.docked?).to eq false
    end

    it "should tell a user if it is empty" do
      bike = Bike.new
      subject.dock_bike bike
      expect(subject.docked?).to eq true
    end
  end
end


