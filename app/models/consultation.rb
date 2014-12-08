class Consultation < ActiveRecord::Base
  attr_accessible :car_model_code, :cons_rate, :consultation_type, :content, :linkman, :phone, :rate_code_id, :rate_codes, :result, :use_car_date,:compound_pickup_date, :compound_return_date
end
