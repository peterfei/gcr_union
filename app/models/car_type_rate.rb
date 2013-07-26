class CarTypeRate < ActiveRecord::Base
  attr_accessible :base_rate, :xdis_rate, :xhour, :prices_included,
    :car_type_id, :base_rate_code_id

  extend Enumerize

  serialize :prices_included, Array
  enumerize :prices_included, in: [:oil, :insure, :driver], multiple: true

  def prices_included_text
    prices_included.map(&:text).join('/')
  end
  belongs_to :car_type
  belongs_to :base_rate_code
end
