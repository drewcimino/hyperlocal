class ChangeCensusTractBoundaryFomatToLongText < ActiveRecord::Migration
  def change
    change_column :census_tracts, :boundary, :longtext
  end
end
