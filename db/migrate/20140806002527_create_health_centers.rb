class CreateHealthCenters < ActiveRecord::Migration
  def change
    create_table :health_centers do |t|
      t.float :latitude
      t.float :longitude
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :name
      t.string :operator
      t.string :status

      t.timestamps
    end
  end
end
