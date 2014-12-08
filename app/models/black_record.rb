class BlackRecord < ActiveRecord::Base
  attr_accessible :cid, :deleted, :email, :name, :phone, :remark, :status
end
