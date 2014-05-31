class CreateCensusTracts < ActiveRecord::Migration
  def change
    create_table :census_tracts do |t|
      t.string :fips
      t.text :boundary

      t.timestamps
    end
  end
end
