# coding: utf-8
class Location < ActiveRecord::Base
  attr_accessible :address, :city_id, :district_id, :end_time, :is24, :latitude, :location_name, :longitude, :phone, :phone, :principal, :principal_phone, :rate_code_list, :start_time, :status

  belongs_to :city
  belongs_to :district
  has_many :drivers
  has_many :car_types

  def to_s
    location_name
  end
 
  def self.rate_code_lists
    [['日租',0],['时租',1],['接机',2],['送机',3],['自定路线',4]]
  end

  def self.status_list
    [['营业中',1],['暂停营业',0]]
  end

  def self.is24_list
    [['是',1],['否',0]]
  end

  def status_text
    (Location.status_list.find { |t,k|  k == self.status.to_i } or []).first
  end

  def rate_code_list_text
    (Location.rate_code_lists.find { |t,k|  k == self.rate_code_list.to_i } or []).first
  end

  def is24_text
    (Location.is24_list.find { |t,k|  k == self.is24.to_i } or []).first
  end
end
