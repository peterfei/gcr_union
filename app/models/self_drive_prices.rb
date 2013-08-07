class SelfDrivePrices < ActiveRecord::Base
  belongs_to :car_model
  belongs_to :location
  attr_accessible :date, :flag, :rate
end
