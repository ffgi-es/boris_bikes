context 'collecting and fixing broken bikes' do
  specify 'collect broken, fix and return working' do
    given_a_docking_station_with_5_working_7_broken_bikes
    when_a_van_collects_the_broken_bikes
    then_we_can_get_5_working_bikes_and_no_more

    given_a_garage
    when_the_van_drops_off_the_bikes
    the_garage_fixes_the_bikes_and_returns_them
    the_van_returns_the_bikes_to_the_station
    then_we_can_get_7_more_working_bikes
  end

  def given_a_docking_station_with_5_working_7_broken_bikes
    @station = DockingStation.new
    5.times { @station.dock_bike Bike.new }
    7.times { @station.dock_bike Bike.new, false }
  end

  def when_a_van_collects_the_broken_bikes
    @van = Van.new
    @van.collect_from @station
  end

  def then_we_can_get_5_working_bikes_and_no_more
    5.times { expect(@station.release_bike).to be_working }
    expect { @station.release_bike }.to raise_error EmptyStationError
  end

  def given_a_garage
    @garage = Garage.new
  end

  def when_the_van_drops_off_the_bikes
    @van.deliver_to @garage
  end

  def the_garage_fixes_the_bikes_and_returns_them
    @garage.fix_bikes
    @van.collect_from @garage
  end

  def the_van_returns_the_bikes_to_the_station
    @van.deliver_to @station
  end

  def then_we_can_get_7_more_working_bikes
    7.times { expect(@station.release_bike).to be_working }
  end
end
