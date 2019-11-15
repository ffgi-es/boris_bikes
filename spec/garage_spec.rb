require 'garage'
require 'bike_collection_examples'

describe Garage do
  let(:broken_bike) { spy(:broken_bike, working?: false, fix: nil) }
  let(:bike) { spy(:bike, working?: true, fix: nil) }
  let(:broken_bikes) { [broken_bike] * 5 }

  it_behaves_like "a bike collection"

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
