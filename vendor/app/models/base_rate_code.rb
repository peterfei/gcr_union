class BaseRateCode < ActiveRecord::Base
  attr_accessible :base_hour, :base_km, :rate_code, :rate_code_name 
  def to_s
    rate_code_name
  end
end
