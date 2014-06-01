class AddRuralToCensusTract < ActiveRecord::Migration
  def change
    add_column :census_tracts, :rural, :boolean
  end
end
