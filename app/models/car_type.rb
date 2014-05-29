# coding: utf-8
class CarType < ActiveRecord::Base
  attr_accessible :big_package, :car_type_code, :image, :car_type_name, :description, :persons, :sequence, :small_package, :status, :car_type_rates_attributes

  mount_uploader :image, AttachmentUploader

  has_many :cars
  has_many :car_models
  has_many :car_type_rates, :dependent => :destroy
  accepts_nested_attributes_for :car_type_rates

  validates :car_type_name, presence: true
  validates :image, presence: {message: '未选择文件'}

  def to_s
    car_type_name
  end

  def type_name_seat
    "#{car_type_name} - #{persons}座"
  end
end
