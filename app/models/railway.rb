class Railway < ActiveRecord::Base
  attr_accessible :city_id, :name, :status
  belongs_to :city
  
  def to_s
    name
  end
end
