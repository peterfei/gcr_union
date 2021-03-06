class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :driver_name
      t.string :driver_phone
      t.string :status
      t.references :company
      t.references :location
      t.string :driver_allowed
      t.integer :driver_year
      t.string :born
      t.timestamps
    end
    add_index :drivers, :company_id
    add_index :drivers, :location_id
  end
end
