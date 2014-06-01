class CreateLowAccessLowIncomeTractShares < ActiveRecord::Migration
  def change
    create_table :low_access_low_income_tract_shares do |t|
      t.string :fips
      t.float :share

      t.timestamps
    end
  end
end
