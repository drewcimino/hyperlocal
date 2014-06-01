class AddLowVehicleToCensusTract < ActiveRecord::Migration
  def change
    add_column :census_tracts, :low_vehicle, :boolean
  end
end
