class Van
  DEFAULT_CAPACITY = 20
  include BikeCollection

  def initialize capacity = DEFAULT_CAPACITY
    @bikes = []
    @capacity = capacity >= 0 ? capacity : DEFAULT_CAPACITY
  end
end
