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

ActiveRecord::Schema.define(:version => 20141206110047) do

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

  create_table "black_records", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "cid"
    t.integer  "status"
    t.integer  "deleted"
    t.text     "remark"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.integer  "city_id"
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
    t.integer  "seat"
    t.integer  "location_id"
    t.integer  "car_type_id"
    t.integer  "car_model_id"
    t.integer  "driver_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "alt_car_tag"
  end

  create_table "cities", :force => true do |t|
    t.string "city_name"
    t.string "city_code"
    t.string "pinyin"
    t.string "status"
  end

  create_table "cms_blocks", :force => true do |t|
    t.integer  "page_id",    :null => false
    t.string   "identifier", :null => false
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cms_blocks", ["page_id", "identifier"], :name => "index_cms_blocks_on_page_id_and_identifier"

  create_table "cms_categories", :force => true do |t|
    t.integer "site_id",          :null => false
    t.string  "label",            :null => false
    t.string  "categorized_type", :null => false
  end

  add_index "cms_categories", ["site_id", "categorized_type", "label"], :name => "index_cms_categories_on_site_id_and_categorized_type_and_label", :unique => true

  create_table "cms_categorizations", :force => true do |t|
    t.integer "category_id",      :null => false
    t.string  "categorized_type", :null => false
    t.integer "categorized_id",   :null => false
  end

  add_index "cms_categorizations", ["category_id", "categorized_type", "categorized_id"], :name => "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", :unique => true

  create_table "cms_files", :force => true do |t|
    t.integer  "site_id",                                          :null => false
    t.integer  "block_id"
    t.string   "label",                                            :null => false
    t.string   "file_file_name",                                   :null => false
    t.string   "file_content_type",                                :null => false
    t.integer  "file_file_size",                                   :null => false
    t.string   "description",       :limit => 2048
    t.integer  "position",                          :default => 0, :null => false
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "cms_files", ["site_id", "block_id"], :name => "index_cms_files_on_site_id_and_block_id"
  add_index "cms_files", ["site_id", "file_file_name"], :name => "index_cms_files_on_site_id_and_file_file_name"
  add_index "cms_files", ["site_id", "label"], :name => "index_cms_files_on_site_id_and_label"
  add_index "cms_files", ["site_id", "position"], :name => "index_cms_files_on_site_id_and_position"

  create_table "cms_layouts", :force => true do |t|
    t.integer  "site_id",                                           :null => false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                                             :null => false
    t.string   "identifier",                                        :null => false
    t.text     "content",    :limit => 16777215
    t.text     "css",        :limit => 16777215
    t.text     "js",         :limit => 16777215
    t.integer  "position",                       :default => 0,     :null => false
    t.boolean  "is_shared",                      :default => false, :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "cms_layouts", ["parent_id", "position"], :name => "index_cms_layouts_on_parent_id_and_position"
  add_index "cms_layouts", ["site_id", "identifier"], :name => "index_cms_layouts_on_site_id_and_identifier", :unique => true

  create_table "cms_pages", :force => true do |t|
    t.integer  "site_id",                                               :null => false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                                                 :null => false
    t.string   "slug"
    t.string   "full_path",                                             :null => false
    t.text     "content",        :limit => 16777215
    t.integer  "position",                           :default => 0,     :null => false
    t.integer  "children_count",                     :default => 0,     :null => false
    t.boolean  "is_published",                       :default => true,  :null => false
    t.boolean  "is_shared",                          :default => false, :null => false
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "cms_pages", ["parent_id", "position"], :name => "index_cms_pages_on_parent_id_and_position"
  add_index "cms_pages", ["site_id", "full_path"], :name => "index_cms_pages_on_site_id_and_full_path"

  create_table "cms_revisions", :force => true do |t|
    t.string   "record_type",                     :null => false
    t.integer  "record_id",                       :null => false
    t.text     "data",        :limit => 16777215
    t.datetime "created_at"
  end

  add_index "cms_revisions", ["record_type", "record_id", "created_at"], :name => "index_cms_revisions_on_record_type_and_record_id_and_created_at"

  create_table "cms_sites", :force => true do |t|
    t.string  "label",                          :null => false
    t.string  "identifier",                     :null => false
    t.string  "hostname",                       :null => false
    t.string  "path"
    t.string  "locale",      :default => "en",  :null => false
    t.boolean "is_mirrored", :default => false, :null => false
  end

  add_index "cms_sites", ["hostname"], :name => "index_cms_sites_on_hostname"
  add_index "cms_sites", ["is_mirrored"], :name => "index_cms_sites_on_is_mirrored"

  create_table "cms_snippets", :force => true do |t|
    t.integer  "site_id",                                           :null => false
    t.string   "label",                                             :null => false
    t.string   "identifier",                                        :null => false
    t.text     "content",    :limit => 16777215
    t.integer  "position",                       :default => 0,     :null => false
    t.boolean  "is_shared",                      :default => false, :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "cms_snippets", ["site_id", "identifier"], :name => "index_cms_snippets_on_site_id_and_identifier", :unique => true
  add_index "cms_snippets", ["site_id", "position"], :name => "index_cms_snippets_on_site_id_and_position"

  create_table "comments", :force => true do |t|
    t.integer  "reservation_id"
    t.text     "text"
    t.integer  "score"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "comments", ["reservation_id"], :name => "index_comments_on_reservation_id"

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
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "dispicher_ip"
    t.string   "uuid"
  end

  create_table "consultations", :force => true do |t|
    t.string   "linkman"
    t.string   "cons_rate"
    t.text     "content"
    t.string   "use_car_date"
    t.string   "result"
    t.string   "phone"
    t.string   "rate_codes"
    t.integer  "rate_code_id"
    t.string   "car_model_code"
    t.string   "consultation_type"
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

  create_table "custom_prices", :force => true do |t|
    t.string   "range"
    t.decimal  "price",               :precision => 10, :scale => 0
    t.integer  "self_drive_price_id"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  add_index "custom_prices", ["self_drive_price_id"], :name => "index_custom_prices_on_self_drive_price_id"

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
    t.integer "suburbs"
  end

  add_index "districts", ["city_id"], :name => "index_districts_on_city_id"

  create_table "drivers", :force => true do |t|
    t.string   "driver_name"
    t.string   "driver_phone"
    t.string   "status"
    t.integer  "company_id"
    t.integer  "location_id"
    t.string   "driver_allowed"
    t.integer  "driver_year"
    t.string   "born"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
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
    t.string   "start_time"
    t.string   "end_time"
    t.integer  "is24"
    t.integer  "status"
    t.integer  "city_id"
    t.integer  "district_id"
    t.integer  "company_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "last_order_id",   :default => 0
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
    t.string   "permission"
  end

  create_table "members", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "mygroup_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "members", ["mygroup_id"], :name => "index_members_on_mygroup_id"

  create_table "mygroups", :force => true do |t|
    t.string   "title"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payment_records", :force => true do |t|
    t.decimal  "amount",         :precision => 10, :scale => 0
    t.string   "payment_type"
    t.integer  "reservation_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "payment_records", ["reservation_id"], :name => "index_payment_records_on_reservation_id"

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
    t.decimal  "total_price",               :precision => 10, :scale => 0
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
    t.integer  "base_rate_code_id"
    t.integer  "pickup_city_id"
    t.integer  "return_city_id"
    t.integer  "pickup_district_id"
    t.integer  "return_district_id"
    t.integer  "pickup_location_id"
    t.integer  "return_location_id"
    t.integer  "airport_id"
    t.integer  "railway_id"
    t.integer  "coupon_id"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "pay_mode"
    t.decimal  "self_driving_prepayment",   :precision => 10, :scale => 0
    t.decimal  "self_driving_overtime",     :precision => 10, :scale => 0
    t.decimal  "self_driving_overdistance", :precision => 10, :scale => 0
    t.decimal  "reservation_base_rate",     :precision => 10, :scale => 0
    t.decimal  "reservation_xdis_rate",     :precision => 10, :scale => 0
    t.decimal  "reservation_xhour",         :precision => 10, :scale => 0
    t.string   "request_from"
  end

  add_index "reservations", ["base_rate_code_id"], :name => "index_reservations_on_base_rate_code_id"
  add_index "reservations", ["car_id"], :name => "index_reservations_on_car_id"
  add_index "reservations", ["car_model_id"], :name => "index_reservations_on_car_model_id"
  add_index "reservations", ["car_type_id"], :name => "index_reservations_on_car_type_id"
  add_index "reservations", ["company_id"], :name => "index_reservations_on_company_id"
  add_index "reservations", ["confirmation"], :name => "index_reservations_on_confirmation"
  add_index "reservations", ["customer_id"], :name => "index_reservations_on_customer_id"
  add_index "reservations", ["driver_id"], :name => "index_reservations_on_driver_id"
  add_index "reservations", ["pickup_location_id"], :name => "index_reservations_on_pickup_location_id"
  add_index "reservations", ["return_location_id"], :name => "index_reservations_on_return_location_id"

  create_table "self_drive_prices", :force => true do |t|
    t.decimal  "weekday",      :precision => 10, :scale => 0
    t.decimal  "weekend",      :precision => 10, :scale => 0
    t.integer  "car_model_id"
    t.integer  "location_id"
    t.decimal  "prepayment",   :precision => 10, :scale => 0
    t.decimal  "overtime",     :precision => 10, :scale => 0
    t.decimal  "overdistance", :precision => 10, :scale => 0
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "self_drive_prices", ["car_model_id"], :name => "index_self_drive_prices_on_car_model_id"
  add_index "self_drive_prices", ["location_id"], :name => "index_self_drive_prices_on_location_id"

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
    t.string   "status"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["username"], :name => "index_users_on_username", :unique => true
  add_index "users", ["uuid"], :name => "index_users_on_uuid", :unique => true

  create_table "value_added_services", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "_type"
    t.decimal  "price",      :precision => 10, :scale => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

end
