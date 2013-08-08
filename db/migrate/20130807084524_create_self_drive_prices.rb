class CreateSelfDrivePrices < ActiveRecord::Migration
  def change
    create_table :self_drive_prices do |t|
      t.date :date
      t.decimal :rate
      t.references :car_model
      t.references :location
      t.string :flag

      t.timestamps
    end
    add_index :self_drive_prices, :car_model_id
    add_index :self_drive_prices, :location_id
  end
end
