class Customer < ActiveRecord::Base
  attr_accessible :creater, :cus_type, :customer_code, :customer_name, :email, :guding_phone, :identity_code, :identity_type_name, :login_name, :password, :phone, :sex, :status
  has_many :reservations
  belongs_to :user
  extend Enumerize
  enumerize :sex, in: [:male, :female], default: :male

  def to_s  
    customer_name 
  end
end
