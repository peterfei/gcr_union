class AddLastOrderIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :last_order_id, :integer, default: 0
  end
end
