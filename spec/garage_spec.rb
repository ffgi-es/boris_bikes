require 'garage'

describe Garage do
  let(:broken_bike) { spy(:broken_bike, working?: false, fix: nil) }
  let(:bike) { spy(:bike, working?: true, fix: nil) }
  let(:broken_bikes) { [broken_bike] * 5 }

  describe "#receive_bikes" do
    it "should accept an array of bike" do
      subject.receive_bikes broken_bikes
      expect(subject.empty?).to be false
    end
  end

  describe "#return_bikes" do
    it "should return an empty array if empty" do
      expect(subject.return_bikes).to eq []
    end

    it "should return an empty array if all bikes are broken" do
      subject.receive_bikes broken_bikes
      expect(subject.return_bikes).to eq []
    end

    it "should return working bikes" do
      subject.receive_bikes [bike]
      subject.receive_bikes [broken_bike]
      subject.receive_bikes [bike]
      subject.receive_bikes [broken_bike]
      expect(subject.return_bikes).to eq [bike]*2
    end

    it "should remove the working bikes" do
      subject.receive_bikes [bike] * 2
      subject.return_bikes
      expect(subject.empty?).to eq true
    end

    it "should leave any broken bikes" do
      subject.receive_bikes [bike]
      subject.receive_bikes [broken_bike]
      subject.return_bikes
      expect(subject.empty?).to eq false
    end
  end

  describe "#empty?" do
    it "should return true if no bikes have been received" do
      expect(subject.empty?).to be true
    end

    it "should return false if bikes have been received" do
      subject.receive_bikes [broken_bike]
      expect(subject.empty?).to be false
    end

    it "should return true if all bikes have been returned" do
      subject.receive_bikes [bike]
      subject.return_bikes
      expect(subject.empty?).to be true
    end
  end

  describe "#fix_bikes" do
    it "should fix broken bikes" do
      subject.receive_bikes [broken_bike]
      subject.fix_bikes
      expect(broken_bike).to have_received(:fix)
    end

    it "shouldn't fix working bikes" do
      subject.receive_bikes [bike]
      subject.fix_bikes
      expect(bike).to_not have_received(:fix)
    end
  end
end
