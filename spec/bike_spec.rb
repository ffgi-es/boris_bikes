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

  describe "#damaged" do
    it "should make the bike not work" do
      subject.damaged
      expect(subject.working?).to be false
    end
  end

  describe "#fix" do
    it "should make the bike work" do
      subject.damaged
      subject.fix
      expect(subject.working?).to be true
    end
  end
end
