class SelfDrivePrice < ActiveRecord::Base
  belongs_to :car_model
  belongs_to :location
  attr_accessible :date, :flag, :rate
  extend Enumerize

  enumerize :flag, in: [:weekday, :weekend, :custome]
end
