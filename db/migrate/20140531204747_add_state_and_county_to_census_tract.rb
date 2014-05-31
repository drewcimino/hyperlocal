class AddStateAndCountyToCensusTract < ActiveRecord::Migration
  def change
    add_column :census_tracts, :state, :string
    add_column :census_tracts, :county, :string
  end
end
