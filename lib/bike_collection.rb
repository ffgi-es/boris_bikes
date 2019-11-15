module BikeCollection
  def capacity
    @capacity
  end

  def empty?
    @bikes.empty?
  end

  def full?
    @bikes.size >= @capacity
  end

  def amount
    @bikes.size
  end

  def receive_bikes bike_arr
    @bikes += bike_arr
  end

  def return_bikes(&block)
    result = []
    if block_given?
      result, @bikes = @bikes.partition(&block)
    else
      result = @bikes
      @bikes = []
    end
    result
  end

  def receive_bikes_from(collection, &block)
    receive_bikes collection.return_bikes(&block)
  end
end
