class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :car_tag
      t.string :color
      t.string :status
      t.integer :receive_model

      t.references :location
      t.references :car_type
      t.references :car_model
      t.references :driver

      t.timestamps
    end
  end
end
