require "bike"

class DockingStation
  attr_reader :bikes

  def initialize
    @bikes = []
  end

  def release_bike
    raise EmptyStationError if self.bikes.empty?
    self.bikes.pop
  end

  def dock_bike bike
    raise FullStationError unless self.bikes.size < 20
    @bikes.push bike
  end

  def docked?
    !self.bikes.empty?
  end
end

class EmptyStationError < StandardError
end

class FullStationError < StandardError
end
