class AddLastOrderIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :last_order_id, :integer
  end
end
