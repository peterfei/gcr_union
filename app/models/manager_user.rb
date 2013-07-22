# coding: utf-8
class ManagerUser < ActiveRecord::Base
  attr_accessible :login_name, :manager_user_type, :password_digest

  def self.manager_user_type_list
    [['个人',0],['企业',1]]
  end

  def manager_user_type_text
    (ManagerUser.manager_user_type_list.find { |t,k|  k == self.manager_user_type.to_i } or []).first
  end
end
