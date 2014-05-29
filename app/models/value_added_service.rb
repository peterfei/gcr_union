class ValueAddedService < ActiveRecord::Base
  attr_accessible :name, :price, :_type, :status

  extend Enumerize
  enumerize :_type, in: [:reservation, :self_driving], default: :reservation
  enumerize :status, in: [:enable, :disable], default: :enable

  validates :name, presence: true, uniqueness: { scope: :_type }
  validates :price, presence: true
  validates :status, presence: true
  validates :_type, presence: true

end
