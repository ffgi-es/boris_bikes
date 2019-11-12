require "docking_station"

describe DockingStation do
  subject {described_class.new}   
  it "should exist"  do
    expect(subject).to be_instance_of DockingStation
  end

  it {is_expected.to respond_to :release_bike}
  
  describe "release_bike" do
    it "should create an instance of bike" do
      expect(subject.release_bike).to be_instance_of Bike
    end
    it "should tell us if the bike is working" do
      bike = subject.release_bike
      expect(bike.working?).to eq true
    end
  end

  it { is_expected.to respond_to :dock_bike }

  describe "#dock_bike" do
    it "should accept a Bike" do
      bike = Bike.new
      expect{ subject.dock_bike bike }.to_not raise_error
    end
  end

  it { is_expected.to have_attributes(bike: nil) }
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


