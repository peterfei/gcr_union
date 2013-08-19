# coding: utf-8
class Car < ActiveRecord::Base
  attr_accessible :car_tag, :color, :status, :receive_model, :location_id, :car_type_id, :car_model_id, :driver_id,:seat

  extend Enumerize
  enumerize :status, in: [:enable,:disable], default: :enable

  belongs_to :location
  belongs_to :car_model
  belongs_to :car_type

  def to_s
    car_tag
  end
end
