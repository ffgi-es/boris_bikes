require "docking_station"

describe DockingStation do
  subject {described_class.new}   
  it "should exist"  do
    expect (subject).to be_instance_of DockingStation
  end
end
