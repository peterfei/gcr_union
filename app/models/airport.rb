class Airport < ActiveRecord::Base
  attr_accessible :name, :city_id, :status
  belongs_to :city

  def to_s
    name
  end
end
