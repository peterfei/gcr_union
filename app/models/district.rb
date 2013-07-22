# coding: utf-8
class District < ActiveRecord::Base
  has_many :locations
  has_many :companies
  belongs_to :city
  attr_accessible :district_code, :district_name, :status, :city_id

  def to_s
    district_name
  end
end
