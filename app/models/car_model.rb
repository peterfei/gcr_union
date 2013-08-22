# coding: utf-8
class CarModel < ActiveRecord::Base
  attr_accessible :car_model, :car_model_atmt, :car_model_code, :car_model_img_url, :car_model_name, :car_model_package, :car_model_size, :car_model_type, :car_type_code, :status, :car_type_id

 # mount_uploader :car_model_img_url, CompanyLogoUploader

  mount_uploader :car_model_img_url, AttachmentUploader
  has_many :cars
  belongs_to :car_type
  has_many :self_drive_prices

  def self.without_prices
    includes(:self_drive_prices).where(:self_drive_prices => {car_model_id: nil})
  end

  def to_s
    car_model_name
  end
end
