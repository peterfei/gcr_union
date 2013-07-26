# coding: utf-8
class CarType < ActiveRecord::Base
  attr_accessible :big_package, :car_type_code, :image, :car_type_name, :description, :persons, :sequence, :small_package, :status

  mount_uploader :image, AttachmentUploader

  has_many :cars
  has_many :car_models

  def to_s
    car_type_name
  end
end
