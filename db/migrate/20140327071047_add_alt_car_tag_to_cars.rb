class AddAltCarTagToCars < ActiveRecord::Migration
  def change
    add_column :cars, :alt_car_tag, :string
  end
end
