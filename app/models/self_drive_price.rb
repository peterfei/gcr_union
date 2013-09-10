# encoding: utf-8
class SelfDrivePrice < ActiveRecord::Base
  attr_accessible :car_model_id, :location_id, :date, :flag, :rate
  attr_accessible :prepayment, :overtime, :overdistance
  belongs_to :car_model
  belongs_to :location
  extend Enumerize

  enumerize :flag, in: [:weekday, :weekend, :custome]

  scope :for, ->(params){
    where(location_id: params[:location_id],
          car_model_id: params[:car_model_id])
  }
  scope :custome_prices, ->{ where(flag: 'custome')  }
  scope :weekend_prices, ->{ find_by_flag('weekend') }

  class << self
    include SelfDrivePricesHelper
    def weekday_prices
      find_by_flag('weekday')
    end

    def range
      range = {}
      custome_prices.to_a.group_by(&:rate).each do |prices,_range|
        dates     = _range.sort_by(&:date).map(&:date)
        calc_range(dates).each do |r|
          range[get_text_range r] = prices
        end
      end
      range
    end

    def car_model
      first.car_model
    end
    def edit_path
      "self_drive_prices/#{car_model.id}/edit"
    end
    def weekday_rate
      find_by_flag('weekday').rate
    end
    def weekend_rate
      find_by_flag('weekend').rate
    end

    def range_insert(options)
      date_range     = options[:date_range]
      custome_prices = options[:custome_prices]
      car_model_id   = options[:car_model_id]
      location_id    = options[:self_drive_price][:location_id]
      range_reset    = options[:range_reset]

      if range_reset
        prices_for(car_model_id).custome_prices.destroy_all
      end
      prices = []
      date_range.zip(custome_prices).each do |range,_prices|
        begin
          _start, _end = range.split(' - ')
          _start       = Date.parse(_start)
          _end         = Date.parse(_end)
          until _start > _end do
            prices << SelfDrivePrice.new(car_model_id: car_model_id,
                                         location_id: location_id,
                                         date: _start,
                                         rate: _prices,
                                         flag: :custome)
            _start += 1.days
          end
        rescue
          next
        end
      end
      prices
    end

  end

  def + other
    self.rate + other.rate
  end
end
