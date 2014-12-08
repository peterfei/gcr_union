class Customer < ActiveRecord::Base
  # attr_accessible :creater, :cus_type, :customer_code, :customer_name, :email, :guding_phone, :identity_code, :identity_type_name, :login_name, :password, :phone, :sex, :status
  attr_accessible :creater, :cus_type, :customer_code, :customer_name, :email, :guding_phone, :identity_code, :identity_type_name, :login_name, :password, :phone, :sex, :status, :user_attributes
  has_many :reservations
  belongs_to :user
  accepts_nested_attributes_for :user
  extend Enumerize
  enumerize :sex, in: [:male, :female], default: :male
  enumerize :identity_type_name, in: [:id], default: :id

  def to_s
    customer_name
  end
end
