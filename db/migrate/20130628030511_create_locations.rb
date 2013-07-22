class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :location_name
      t.string :phone
      t.string :address
      t.string :principal
      t.string :principal_phone
      t.string :rate_code_list
      t.string :longitude
      t.string :latitude
      t.datetime :start_time
      t.datetime :end_time
      t.integer :is24
      t.integer :status

      t.references :city
      t.references :district

      t.timestamps
    end
  end
end
