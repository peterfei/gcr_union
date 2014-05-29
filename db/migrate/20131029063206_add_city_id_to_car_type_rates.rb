class AddCityIdToCarTypeRates < ActiveRecord::Migration
  def change
    add_column :car_type_rates, :city_id, :integer
  end
end
