# coding: utf-8
class Company < ActiveRecord::Base
  attr_accessible :address, :comp_des, :company_full_name, :company_name, :email, :fax, :link_man, :link_man_phone, :logo_url, :phone, :reg_money, :status, :taxpayer_code, :city_id, :district_id

  #mount_uploader :logo_url, CompanyLogoUploader

  self.primary_key = :id
  has_many :drivers
  belongs_to :city
  belongs_to :district
  has_many :manager_users
  #加盟商状态
  def self.status_list
    [['启用',0],['停用',1],['审核',2]]
  end

  #[:status].each do |m|
  #  define_method(m) { Hash[self.class.send "#{m}_list"].invert[read_attribute(m)] }
  #end

  def status_text
    (Company.status_list.find { |t,k|  k == self.status.to_i } or []).first
  end

  def to_s
    company_name
  end
end
