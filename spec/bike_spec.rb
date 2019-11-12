require 'bike'

describe Bike do
  subject { described_class.new }
  
  it { is_expected.to be_instance_of Bike }
  it { is_expected.to respond_to(:working?) }
end
