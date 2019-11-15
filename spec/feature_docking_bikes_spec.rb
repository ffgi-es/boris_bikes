require 'docking_station'
require 'bike'

context 'Docking Bikes' do
  before(:each) { allow($stdout).to receive(:write) }
  specify 'Docking a bike' do
    given_there_is_a_docking_station
    when_i_dock_a_bike
    then_i_can_see_a_bike
    then_i_can_get_a_working_bike
  end

  def given_there_is_a_docking_station
    @station = DockingStation.new
  end

  def when_i_dock_a_bike
    @station.dock_bike Bike.new
  end

  def then_i_can_see_a_bike
    expect(@station.docked?).to eq true
  end

  def then_i_can_get_a_working_bike
    bike = @station.release_bike
    expect(bike).to be_instance_of Bike
    expect(bike).to be_working
  end

  specify 'Docking broken bikes' do
    given_there_is_a_docking_station
    when_i_dock_a_bike
    and_i_dock_a_broken_bike
    then_i_can_get_a_working_bike
    but_i_cant_get_another_bike
  end

  def and_i_dock_a_broken_bike
    @station.dock_bike Bike.new, false
  end

  def but_i_cant_get_another_bike
    expect { @station.release_bike }.to raise_error NoWorkingBikesError
  end

  specify 'High capacity docking stations' do
    given_there_is_a_docking_station_with_a_capacity_of_30
    when_i_dock_30_bikes
    then_i_cant_dock_another_bike
  end

  def given_there_is_a_docking_station_with_a_capacity_of_30
    @station = DockingStation.new 30
  end

  def when_i_dock_30_bikes
    30.times { @station.dock_bike Bike.new }
  end

  def then_i_cant_dock_another_bike
    expect { @station.dock_bike Bike.new }.to raise_error FullStationError
  end
end
