class Garage
  DEFAULT_CAPACITY = 20
  include BikeCollection

  def initialize capacity = DEFAULT_CAPACITY
    @bikes = []
    @capacity = capacity >= 0 ? capacity : DEFAULT_CAPACITY
  end

  def fix_bikes
    @bikes.each { |bike| bike.fix unless bike.working? }
  end
end
