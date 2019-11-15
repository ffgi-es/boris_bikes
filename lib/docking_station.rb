require 'bike_collection'

class DockingStation
  DEFAULT_CAPACITY = 20

  include BikeCollection

  def initialize capacity = DEFAULT_CAPACITY
    @bikes = []
    @capacity = capacity >= 0 ? capacity : DEFAULT_CAPACITY
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

  private
  
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
