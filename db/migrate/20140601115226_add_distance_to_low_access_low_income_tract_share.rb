class AddDistanceToLowAccessLowIncomeTractShare < ActiveRecord::Migration
  def change
    add_column :low_access_low_income_tract_shares, :distance, :float
  end
end
