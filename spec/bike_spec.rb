require 'bike'

describe Bike do
  describe "#working?" do
    it "should be working if nothing has happened" do
      expect(subject.working?).to be true
    end

    it "should return false if it is damaged" do
      subject.damaged
      expect(subject.working?).to be false
    end
  end
end
