require "bike"

class DockingStation
  attr_reader :bike

  def release_bike
    raise EmptyStationError if self.bike.nil?
    result = self.bike
    @bike = nil
    return result
  end

  def dock_bike bike
    @bike = bike
  end

  def docked?
    !self.bike.nil?
  end
end

class EmptyStationError < StandardError
end
