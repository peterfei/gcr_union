class ValueAddedService < ActiveRecord::Base
  attr_accessible :name, :price, :_type, :status

  extend Enumerize
  enumerize :_type, in: [:reservation, :self_driving], default: :reservation
  enumerize :status, in: [:enable, :disable], default: :enable
end
