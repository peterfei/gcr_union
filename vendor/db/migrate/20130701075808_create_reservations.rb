class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :confirmation
      t.string :reservation_person_phone
      t.integer :source_code
      t.string :up_address
      t.string :down_address
      t.datetime :pickup_date
      t.datetime :return_date
      t.integer :passenger_num
      t.string :status

      t.decimal :total_price
      t.integer :send_status
      t.string  :invoice_title
      t.string  :send_address
      t.string  :receiver
      t.string  :receiver_phone
      t.string  :special_passenger
      t.string  :special_requirements

      t.string  :up_construction
      t.string  :down_construction
      t.string  :airline
      t.string  :train_number
      t.string  :remark
      t.string  :rental_range
      t.integer  :use_hour
      t.integer  :use_day
      t.string  :attachment

      t.string   :passenger
      t.string   :passenger_phone

      t.references :car_type
      t.references :car_model
      t.references :car
      t.references :customer
      t.references :company
      t.references :driver
      t.references :location
      t.references :base_rate_code

      t.references :pickup_city
      t.references :return_city
      t.references :pickup_district
      t.references :return_district

      t.references :airport
      t.references :railway
      t.references :coupon

      t.timestamps

    end
    add_index :reservations, :confirmation
    add_index :reservations, :car_type_id
    add_index :reservations, :car_model_id
    add_index :reservations, :car_id
    add_index :reservations, :customer_id
    add_index :reservations, :company_id
    add_index :reservations, :driver_id
    add_index :reservations, :location_id
    add_index :reservations, :base_rate_code_id
  end
end
