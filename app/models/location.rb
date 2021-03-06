# coding: utf-8
class Location < ActiveRecord::Base
  attr_accessible :address, :city_id, :district_id, :end_time, :is24,
    :latitude, :location_name, :longitude, :phone, :phone, :principal,
    :principal_phone, :rate_code_list, :start_time, :status,:company_id

  belongs_to :company
  belongs_to :city
  belongs_to :district
  has_many   :drivers
  has_many :cars
  has_many   :car_types
  has_many   :self_drive_prices

  has_many  :car_models, through: :self_drive_prices
  validates :location_name,   presence: { message: '请输入门店名称' },uniqueness: {message:"该门店名称已占用"}
  validates :address,   presence: { message: '请输入街道名称' }
  validates :phone,           presence: { message: '请输入门店手机号码' }
  validates :phone,           presence: { message: '请输入门店手机号码' }
  validates :company_id,      presence: { message: '请输入所属公司' }
  validates :city_id,         presence: { message: '请输入门店所在城市' }
  validates :district_id,     presence: { message: '请输入门店所在城市区域' }
  validates :principal,       presence: { message: '请输入门店联系人姓名' }
  validates :principal_phone, presence: { message: '请输入门店联系人手机号码' }
  validates :status,          presence: { message: '请输入门店工作状态' }

  extend Enumerize
  serialize :rate_code_list, Array
  enumerize :rate_code_list, in: {'日租'=>0,'时租'=>1,'接机'=>2,'送机'=>3,'自定路线'=>4}, multiple: true

  enumerize :status, in: {enable: 1, disable: 0}, default: :enable, scope: true

  def to_s
    location_name
  end
  def destroy
    unless drivers.count==0 or cars.count==0 
      super
    end
  end

  def self.is24_list
    [['是',1],['否',0]]
  end
  def self.hour_list
    h_list = {}
    (0..23).each do |hour|
      if hour<10
        hour = "%02d" % hour
      end
      hour = hour.to_s
      h_list[hour] = hour
    end
    h_list
  end

  def self.minute_list
    m_list = {}
    (0..59).each do |min|
      if min<10
        min = "%02d" % min
      end
      min = min.to_s
      m_list[min] = min
    end
    m_list
  end

  def rate_code_list_text
    (Location.rate_code_lists.find { |t,k|  k == self.rate_code_list.to_i } or []).first
  end

  def is24_text
    (Location.is24_list.find { |t,k|  k == self.is24.to_i } or []).first
  end

  def display_name
    "#{self.company}-#{self.location_name}"
  end
end
