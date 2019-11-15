require 'bike_collection'

shared_examples_for "a bike collection" do
  let(:collection) { described_class.new }
  let(:bike) { double(:bike, working?: true) }
  let(:broken_bike) { double(:broken_bike, working?: false) }
  let(:mixed_bikes) { ([bike]*2) + ([broken_bike]*2) + [bike] }

  context "initialize with varying capacities" do
    it "should have a default capacity" do
      expect(collection.capacity).to eq described_class::DEFAULT_CAPACITY
    end
    
    it "should have a capacity of 30 if specified at creation" do
      collection = described_class.new 30
      expect(collection.capacity).to eq 30
    end

    it "should have a capacity of 15 if specified at creation" do
      collection = described_class.new 15
      expect(collection.capacity).to eq 15
    end

    it "shouldn't allow a negative capacity" do
      collection = described_class.new -1
      expect(collection.capacity).to eq described_class::DEFAULT_CAPACITY
    end
  end

  describe "#empty?" do
    it "should return true if no bikes have been received" do
      expect(collection.empty?).to be true
    end
  end

  describe "#full?" do
    it "should return false if there are no bikes" do
      expect(collection.full?).to be false
    end

    it "should return false if there are some bikes but fewer than capacity" do
      skip if described_class::DEFAULT_CAPACITY < 2
      collection.receive_bikes [bike] * (described_class::DEFAULT_CAPACITY - 1)
    end

    it "should return true if there are a capacity number of bikes" do
      collection.receive_bikes [bike] * described_class::DEFAULT_CAPACITY
      expect(collection.full?).to be true
    end
  end

  describe "#amount?" do
    it "should return 0 if no bikes have been received" do
      expect(collection.amount).to eq 0
    end
  end

  describe "#receive_bikes" do
    it "shouldn't be empty after receiving bikes" do
      collection.receive_bikes mixed_bikes
      expect(collection.empty?).to be false
    end

    it "should store the bikes" do
      collection.receive_bikes mixed_bikes
      expect(collection.amount).to eq 5
    end
  end

  describe "#return_bikes" do
    it "should return an empty array if empty" do
      expect(collection.return_bikes).to eq []
    end

    it "should return all bikes if no condition provided" do
      collection.receive_bikes mixed_bikes
      expect(collection.return_bikes.size).to eq 5
    end

    it "should return bikes according to condidtion block" do
      collection.receive_bikes mixed_bikes
      result = collection.return_bikes { |b| b.working? }
      expect(result.size).to eq 3
    end

    it "should remove the all bikes from itself" do
      collection.receive_bikes mixed_bikes
      collection.return_bikes
      expect(collection.empty?).to eq true
    end
  end

  describe "#receive_bikes_from" do
    let(:other) do
      this = described_class.new
      this.receive_bikes mixed_bikes
      this
    end

    it "should take all the bikes from the other collection if no condition" do
      collection.receive_bikes_from other
      expect(collection.amount).to eq 5
      expect(other.amount).to eq 0
    end

    it "should only take working bikes if condition is provided" do
      collection.receive_bikes_from(other) { |b| b.working? }
      expect(collection.amount).to eq 3
      expect(other.amount).to eq 2
    end
  end
end
