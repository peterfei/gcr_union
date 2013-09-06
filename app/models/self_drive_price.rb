class SelfDrivePrice < ActiveRecord::Base
  belongs_to :car_model
  belongs_to :location
  has_many :custom_prices, :dependent => :destroy
  attr_accessible :overdistance, :overtime, :prepayment,
    :weekday, :weekend, :location_id, :car_model_id, :custom_prices_attributes

  accepts_nested_attributes_for :custom_prices
end
