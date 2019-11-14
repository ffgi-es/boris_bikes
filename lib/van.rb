class Van
  def collect_from storage
    @bikes = storage.return_bikes
  end

  def deliver_to storage
    storage.receive_bikes @bikes
  end
end
