#encoding:utf-8
class SelfDriving < Reservation

  extend Enumerize

  serialize :special_requirements, Array
  enumerize :special_requirements, in: %w/GPS导航 儿童座椅/, multiple: true
  enumerize :pay_mode, in: [:online, :location, :membership], default: :online

  validates :pickup_city_id, presence: true
  validates :return_city_id, presence: true
  validates :pickup_location_id, presence: true
  validates :return_location_id, presence: true

  def self_drive_price
    SelfDrivePrice.find_by_car_model_id_and_location_id car_model_id, pickup_location_id
  end
end
