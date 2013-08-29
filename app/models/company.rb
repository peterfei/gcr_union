# coding: utf-8
class Company < ActiveRecord::Base
  attr_accessible :address, :created_at ,:updated_at, :comp_des, :company_full_name, :company_name, :email, :fax, :link_man, :link_man_phone, :logo_url, :phone, :reg_money, :status, :taxpayer_code, :city_id, :district_id

  #mount_uploader :logo_url, CompanyLogoUploader
  has_many :drivers
  has_many :locations
  has_many :manager_users
  belongs_to :city
  belongs_to :district

  validates :company_name,      :presence => { :message => '请输入公司简称' }
  validates :company_full_name, :presence => { :message => '请输入公司全称' }
  validates :reg_money,         :presence => { :message => '请输入注册资金' }
  validates :taxpayer_code,     :presence => { :message => '请输入营业执照' }
  #before_destroy :company_with_locations? 

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
    company_name||''
  end
  def destroy 
     if locations.count==0 
       super 
     end
  end
  private 
    def company_with_locations?   
      errors.add(:base,"can't destroy company with locations") unless locations.count==0 
      errors.blank?
    end
end
