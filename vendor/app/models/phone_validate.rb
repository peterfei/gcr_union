class PhoneValidate < ActiveRecord::Base
  attr_accessible :overdue_date, :phone_number, :validate_code
end
