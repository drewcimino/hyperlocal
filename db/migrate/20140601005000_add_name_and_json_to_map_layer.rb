class AddNameAndJsonToMapLayer < ActiveRecord::Migration
  def change
    add_column :map_layers, :name, :string
    add_column :map_layers, :json, :longtext
  end
end
