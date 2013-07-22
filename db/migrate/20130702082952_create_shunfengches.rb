class CreateShunfengches < ActiveRecord::Migration
  def change
    create_table :shunfengches do |t|
      t.datetime :start_date
      t.decimal :price
      t.integer :status
      t.string :up_address
      t.string :down_address
      t.references :reservation
      t.references :car
      t.references :driver

      t.timestamps
    end
    add_index :shunfengches, :reservation_id
    add_index :shunfengches, :car_id
    add_index :shunfengches, :driver_id
  end
end
