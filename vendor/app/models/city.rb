# coding: utf-8
class City < ActiveRecord::Base
  attr_accessible :city_code, :city_name, :pinyin, :status

  has_many :districts
  has_many :airports
  has_many :railway
  has_many :locations
  has_many :companies

  def to_s
    city_name
  end
end
