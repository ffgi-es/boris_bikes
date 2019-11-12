require "bike"

class DockingStation
  attr_reader :bike

  def release_bike
    Bike.new
  end

  def dock_bike bike
    @bike = bike
  end

  def docked?
    !self.bike.nil?
  end
end
