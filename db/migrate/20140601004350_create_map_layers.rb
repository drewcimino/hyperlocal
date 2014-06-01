class CreateMapLayers < ActiveRecord::Migration
  def change
    create_table :map_layers do |t|

      t.timestamps
    end
  end
end
