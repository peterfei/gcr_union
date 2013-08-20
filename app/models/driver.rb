# coding: utf-8
class Driver < ActiveRecord::Base
  belongs_to :company
  belongs_to :location
  attr_accessible :driver_name, :driver_phone, :status, :company_id, :location_id,:driver_allowed,:driver_year,:born

  #加盟商状态
  #def self.status_list
  #  [['待租',0],['在租',1]]
  #end
  extend Enumerize
  enumerize :status, in: [:enable,:disable], default: :enable
  enumerize :driver_allowed ,in:[:A,:B]

  validates :location_id, :presence => {message: '门店不能为空'}
  validates :company_id, :presence => {message: '所属公司不能为空'}
  validates :driver_name, :presence => {message: '驾驶员姓名不能为空'}
  validates :driver_phone, :presence => {message: '驾驶员手机不能为空'}
  validates :driver_allowed, :presence => {message: '驾驶员准驾车型不能为空'}
  validates :driver_year, :presence => {message: '驾驶员驾龄不能为空'}
  validates :born, :presence => {message: '籍贯不能为空'}
  #[:status].each do |m|
  #  define_method(m) { Hash[self.class.send "#{m}_list"].invert[read_attribute(m)] }
  #end

  #def status_text
  #  (Driver.status_list.find { |t,k|  k == self.status.to_i } or []).first
  #end
end
