class Comment < ActiveRecord::Base
  belongs_to :reservation
  attr_accessible :score, :text
end
