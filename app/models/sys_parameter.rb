#encoding:utf-8
class SysParameter < ActiveRecord::Base
  attr_accessible :para_desc, :para_name, :para_value ,:para_id
  self.table_name = "sys_parameters"
  self.primary_key = "para_id"

  validates :para_desc,   presence: { message: '请输入描述' }
  validates :para_name,   presence: { message: '请输入名称' },uniqueness: {message:"该门店名称已占用"}
  validates :para_value,   presence: { message: '请输入值' }
  def self.get_url
    SysParameter.find(1).para_value + '?' + SysParameter.find(2).para_value
  end
end
