class CustomPrice < ActiveRecord::Base
  belongs_to :self_drive_price
  attr_accessible :price, :range

  validates :range, presence: true
  validates :price, presence: true
end
