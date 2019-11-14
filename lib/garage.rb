class Garage
  def initialize
    @bikes = []
  end

  def receive_bikes bike_array
    @bikes += bike_array
  end

  def return_bikes
    result, @bikes = @bikes.partition { |bike| bike.working? }
    result
  end

  def fix_bikes
    @bikes.each { |bike| bike.fix unless bike.working? }
  end

  def empty?
    @bikes.empty?
  end
end
