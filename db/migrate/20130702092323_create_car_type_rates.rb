class CreateCarTypeRates < ActiveRecord::Migration
  def change
    create_table :car_type_rates do |t|
      t.integer :base_rate
      t.integer :xhour
      t.integer :xdis_rate
      t.string  :prices_included
      t.references :car_type
      t.references :base_rate_code

      t.timestamps
    end
    add_index :car_type_rates, :car_type_id
    add_index :car_type_rates, :base_rate_code_id
  end
end
