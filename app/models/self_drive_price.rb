class SelfDrivePrice < ActiveRecord::Base
  attr_accessible :car_model_id, :location_id, :date, :flag, :rate
  belongs_to :car_model
  belongs_to :location
  attr_accessible :date, :flag, :rate
  extend Enumerize

  enumerize :flag, in: [:weekday, :weekend, :custome]
end
