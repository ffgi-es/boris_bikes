require "bike"

class DockingStation
  attr_reader :bikes

  def initialize
    @bikes = []
  end

  def release_bike
    raise EmptyStationError if empty?
    self.bikes.pop
  end

  def dock_bike bike
    raise FullStationError if full?
    @bikes.push bike
  end

  def docked?
    !self.bikes.empty?
  end

  private
  
  def full?
    self.bikes.size >= 20
  end

  def empty?
    self.bikes.empty?
  end
end

class EmptyStationError < StandardError
end

class FullStationError < StandardError
end
