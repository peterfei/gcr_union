class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :driver_name
      t.string :driver_phone
      t.integer :status
      t.references :company
      t.references :location

      t.timestamps
    end
    add_index :drivers, :company_id
    add_index :drivers, :location_id
  end
end
