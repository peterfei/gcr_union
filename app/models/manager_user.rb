# coding: utf-8
class ManagerUser < ActiveRecord::Base
  attr_accessible :login_name, :manager_user_type, :password_digest,:password,:origin,:role,:company_id
  has_secure_password
  belongs_to :company
  ROLES = [['运营中心','admin'], ['呼叫中心','call_center'], ['加盟商', 'oprator']] 

  validates :login_name, presence: true
  validates :password, presence: true, on: :create
  validates :company_id, presence: true, if: Proc.new{|p| p.role=='oprator'}
  def self.manager_user_type_list
    [['个人',0],['企业',1]]
  end

  def manager_user_type_text
    (ManagerUser.manager_user_type_list.find { |t,k|  k == self.manager_user_type.to_i } or []).first
  end
  #REVIEW 页面取值
  self.attribute_names.each do |key|
    if /role$/=~key
      define_method("#{key}_text") do 
        Hash[ROLES].invert[read_attribute(key.to_sym)]
      end
    end
  end
  before_save do  |user|
    if user.role=='oprator' and user.company_id==nil
        o=Company.new
        o.save(validate: false)
        user.company_id = o.id
    end
  end
  def to_s
     login_name
  end
end
