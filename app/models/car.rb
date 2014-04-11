# coding: utf-8
class Car < ActiveRecord::Base
  attr_accessible :car_tag, :color, :status, :receive_model,
    :location_id, :car_type_id, :car_model_id, :driver_id,
    :seat, :alt_car_tag

  validates :seat, presence: true
  validates :car_tag, presence: { message: '不能为空' }, uniqueness: {message:"已占用"}
  # validates :color,   format: { message: '不能为空且只允许为字符' ,:with => /^[^0-9.,]+$/}

  extend Enumerize
  enumerize :status, in: [:enable,:disable], default: :enable

  belongs_to :location
  belongs_to :car_model
  belongs_to :car_type

  def to_s
    car_tag
  end
  def car_model_name
    car_model.car_model_name
  end
  def self.available car_type_id,seat
    where(car_type_id:car_type_id)
  end

  before_save :car_type_wr
  def car_type_wr
    write_attribute :car_type_id, car_model.car_type_id
  end
end
