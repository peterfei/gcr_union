class SysParameter < ActiveRecord::Base
  attr_accessible :para_desc, :para_name, :para_value ,:para_id
  self.table_name = "sys_parameters"
  self.primary_key = "para_id"

  def self.get_url
    SysParameter.find(1).para_value + '?' + SysParameter.find(2).para_value
  end
end
