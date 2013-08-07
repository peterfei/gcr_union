# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130806090611) do

  create_table "airports", :force => true do |t|
    t.string  "name"
    t.integer "city_id"
    t.string  "status"
  end

  create_table "base_rate_codes", :force => true do |t|
    t.string   "rate_code"
    t.string   "rate_code_name"
    t.integer  "base_hour"
    t.integer  "base_km"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "call_centers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "car_models", :force => true do |t|
    t.string   "car_model_code"
    t.string   "car_model_name"
    t.string   "car_model"
    t.string   "car_model_type"
    t.string   "car_model_img_url"
    t.string   "car_model_package"
    t.string   "car_model_size"
    t.string   "car_model_atmt"
    t.string   "status"
    t.integer  "car_type_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "car_type_rates", :force => true do |t|
    t.integer  "base_rate"
    t.integer  "xhour"
    t.integer  "xdis_rate"
    t.string   "prices_included"
    t.integer  "car_type_id"
    t.integer  "base_rate_code_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "car_type_rates", ["base_rate_code_id"], :name => "index_car_type_rates_on_base_rate_code_id"
  add_index "car_type_rates", ["car_type_id"], :name => "index_car_type_rates_on_car_type_id"

  create_table "car_types", :force => true do |t|
    t.string   "car_type_code"
    t.string   "car_type_name"
    t.string   "description"
    t.integer  "persons"
    t.integer  "sequence"
    t.integer  "big_package"
    t.integer  "small_package"
    t.string   "image"
    t.string   "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "cars", :force => true do |t|
    t.string   "car_tag"
    t.string   "color"
    t.string   "status"
    t.integer  "receive_model"
    t.integer  "location_id"
    t.integer  "car_type_id"
    t.integer  "car_model_id"
    t.integer  "driver_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "cities", :force => true do |t|
    t.string "city_name"
    t.string "city_code"
    t.string "pinyin"
    t.string "status"
  end

  create_table "companies", :force => true do |t|
    t.string   "company_name"
    t.string   "company_full_name"
    t.string   "taxpayer_code"
    t.float    "reg_money"
    t.string   "link_man"
    t.string   "link_man_phone"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "address"
    t.string   "logo_url"
    t.text     "comp_des"
    t.integer  "status"
    t.integer  "city_id"
    t.integer  "district_id"
    t.integer  "manager_user_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "coupons", :force => true do |t|
    t.string   "coupon_code"
    t.decimal  "denomination", :precision => 10, :scale => 0
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "customer_code"
    t.string   "customer_name"
    t.string   "sex"
    t.string   "phone"
    t.string   "email"
    t.string   "identity_type_name"
    t.string   "identity_code"
    t.string   "login_name"
    t.string   "password"
    t.integer  "status"
    t.integer  "cus_type"
    t.string   "creater"
    t.string   "guding_phone"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "districts", :force => true do |t|
    t.string  "district_code"
    t.string  "district_name"
    t.string  "status"
    t.integer "city_id"
  end

  add_index "districts", ["city_id"], :name => "index_districts_on_city_id"

  create_table "drivers", :force => true do |t|
    t.string   "driver_name"
    t.string   "driver_phone"
    t.string   "status"
    t.integer  "company_id"
    t.integer  "location_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "drivers", ["company_id"], :name => "index_drivers_on_company_id"
  add_index "drivers", ["location_id"], :name => "index_drivers_on_location_id"

  create_table "locations", :force => true do |t|
    t.string   "location_name"
    t.string   "phone"
    t.string   "address"
    t.string   "principal"
    t.string   "principal_phone"
    t.string   "rate_code_list"
    t.string   "longitude"
    t.string   "latitude"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "is24"
    t.integer  "status"
    t.integer  "city_id"
    t.integer  "district_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "manager_users", :force => true do |t|
    t.string   "password_digest"
    t.string   "login_name"
    t.integer  "manager_user_type"
    t.string   "origin"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "role"
    t.integer  "company_id"
  end

  create_table "phone_validates", :force => true do |t|
    t.string   "phone_number"
    t.string   "validate_code"
    t.datetime "overdue_date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "railways", :force => true do |t|
    t.string  "name"
    t.integer "city_id"
    t.string  "status"
  end

  create_table "reservations", :force => true do |t|
    t.string   "confirmation"
    t.string   "reservation_person_phone"
    t.integer  "source_code"
    t.string   "up_address"
    t.string   "down_address"
    t.datetime "pickup_date"
    t.datetime "return_date"
    t.integer  "passenger_num"
    t.string   "status"
    t.decimal  "total_price",              :precision => 10, :scale => 0
    t.integer  "send_status"
    t.string   "invoice_title"
    t.string   "send_address"
    t.string   "receiver"
    t.string   "receiver_phone"
    t.string   "special_passenger"
    t.string   "special_requirements"
    t.string   "up_construction"
    t.string   "down_construction"
    t.string   "airline"
    t.string   "train_number"
    t.string   "remark"
    t.string   "rental_range"
    t.integer  "use_hour"
    t.integer  "use_day"
    t.string   "attachment"
    t.string   "passenger"
    t.string   "passenger_phone"
    t.integer  "car_type_id"
    t.integer  "car_model_id"
    t.integer  "car_id"
    t.integer  "customer_id"
    t.integer  "company_id"
    t.integer  "driver_id"
    t.integer  "location_id"
    t.integer  "base_rate_code_id"
    t.integer  "pickup_city_id"
    t.integer  "return_city_id"
    t.integer  "pickup_district_id"
    t.integer  "return_district_id"
    t.integer  "airport_id"
    t.integer  "railway_id"
    t.integer  "coupon_id"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  add_index "reservations", ["base_rate_code_id"], :name => "index_reservations_on_base_rate_code_id"
  add_index "reservations", ["car_id"], :name => "index_reservations_on_car_id"
  add_index "reservations", ["car_model_id"], :name => "index_reservations_on_car_model_id"
  add_index "reservations", ["car_type_id"], :name => "index_reservations_on_car_type_id"
  add_index "reservations", ["company_id"], :name => "index_reservations_on_company_id"
  add_index "reservations", ["confirmation"], :name => "index_reservations_on_confirmation"
  add_index "reservations", ["customer_id"], :name => "index_reservations_on_customer_id"
  add_index "reservations", ["driver_id"], :name => "index_reservations_on_driver_id"
  add_index "reservations", ["location_id"], :name => "index_reservations_on_location_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shunfengches", :force => true do |t|
    t.datetime "start_date"
    t.decimal  "price",          :precision => 10, :scale => 0
    t.integer  "status"
    t.string   "up_address"
    t.string   "down_address"
    t.integer  "reservation_id"
    t.integer  "car_id"
    t.integer  "driver_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "shunfengches", ["car_id"], :name => "index_shunfengches_on_car_id"
  add_index "shunfengches", ["driver_id"], :name => "index_shunfengches_on_driver_id"
  add_index "shunfengches", ["reservation_id"], :name => "index_shunfengches_on_reservation_id"

  create_table "sys_parameters", :primary_key => "para_id", :force => true do |t|
    t.string "para_name"
    t.string "para_value"
    t.string "para_desc"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "phone"
    t.string   "password_digest"
    t.string   "email"
    t.string   "uuid"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["username"], :name => "index_users_on_username", :unique => true
  add_index "users", ["uuid"], :name => "index_users_on_uuid", :unique => true

end
