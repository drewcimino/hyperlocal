class ChangeMapLayerJsonToGeojsonData < ActiveRecord::Migration
  def change
    rename_column :map_layers, :json, :geojson_data
  end
end
