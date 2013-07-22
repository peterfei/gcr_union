class Shunfengche < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :car
  belongs_to :driver
  attr_accessible :down_address, :price, :start_date, :status, :up_address
end
