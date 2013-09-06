class SelfDrivePrice < ActiveRecord::Base
  belongs_to :car_model
  belongs_to :location
  attr_accessible :overdistance, :overtime, :prepayment,
    :weekday, :weekend, :location_id, :car_model_id
end
