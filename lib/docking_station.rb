class DockingStation
  DEFAULT_CAPACITY = 20
  attr_reader :capacity

  def initialize capacity = DEFAULT_CAPACITY
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    raise EmptyStationError if empty?
    raise NoWorkingBikesError unless working_bikes?
    @bikes.rotate! until @bikes.first.working?
    @bikes.shift
  end

  def dock_bike(bike, working = true)
    raise FullStationError if full?
    report_damaged bike unless working
    @bikes.push bike
  end

  def docked?
    !@bikes.empty?
  end

  def return_bikes
    @bikes, result = @bikes.partition { |bike| bike.working? }
    result
  end

  def receive_bikes bike_arr
    @bikes += bike_arr
  end

  private
  
  def full?
    @bikes.size >= capacity
  end

  def empty?
    @bikes.empty?
  end

  def working_bikes?
    @bikes.any? { |bike| bike.working? }
  end

  def report_damaged bike
    puts "Thank you for the report"
    bike.damaged
  end
end

class EmptyStationError < StandardError
end

class FullStationError < StandardError
end

class NoWorkingBikesError < StandardError
end
