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
      t.string :start_time
      t.string :end_time
      t.integer :is24
      t.integer :status

      t.references :city
      t.references :district
      t.references :company
      t.timestamps
    end
  end
end
