require "bike"

class DockingStation
  DEFAULT_CAPACITY = 20
  attr_reader :bikes, :capacity

  def initialize capacity = DEFAULT_CAPACITY
    @bikes = []
    @capacity = capacity
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
    self.bikes.size >= DEFAULT_CAPACITY
  end

  def empty?
    self.bikes.empty?
  end
end

class EmptyStationError < StandardError
end

class FullStationError < StandardError
end
