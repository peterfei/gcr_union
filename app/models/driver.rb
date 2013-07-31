# coding: utf-8
class Driver < ActiveRecord::Base
  belongs_to :company
  belongs_to :location
  attr_accessible :driver_name, :driver_phone, :status, :company_id, :location_id

  #加盟商状态
  #def self.status_list
  #  [['待租',0],['在租',1]]
  #end
  extend Enumerize
  enumerize :status, in: [:enable,:disable], default: :enable


  #[:status].each do |m|
  #  define_method(m) { Hash[self.class.send "#{m}_list"].invert[read_attribute(m)] }
  #end

  #def status_text
  #  (Driver.status_list.find { |t,k|  k == self.status.to_i } or []).first
  #end
end
