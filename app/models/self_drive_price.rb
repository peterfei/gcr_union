# encoding: utf-8
class SelfDrivePrice < ActiveRecord::Base
  belongs_to :car_model
  belongs_to :location
  has_many :custom_prices, :dependent => :destroy
  attr_accessible :overdistance, :overtime, :prepayment,
    :weekday, :weekend, :location_id, :car_model_id, :custom_prices_attributes

  accepts_nested_attributes_for :custom_prices, allow_destroy: true,
    :reject_if => lambda { |p| p[:range].blank? || p[:price].blank? }

  validates :car_model_id, presence: true, uniqueness: { scope: :location_id,
                                                         message: "门店中的车辆品牌只能有一种价格" }

  validates :location_id, presence: {message: '门店不能为空'}
  validates :weekday,  presence: {message: '周内价格不能为空'}
  validates :weekend,  presence: {message: '周内价格不能为空'}
end
