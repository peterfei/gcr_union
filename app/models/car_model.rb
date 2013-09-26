# coding: utf-8
class CarModel < ActiveRecord::Base
  attr_accessible :car_model, :car_model_atmt, :car_model_code,
    :car_model_img_url, :car_model_name, :car_model_package,
    :car_model_size, :car_model_type, :car_type_code, :status,
    :car_type_id

  #mount_uploader :car_model_img_url, CompanyLogoUploader

  belongs_to :car_type
  has_many   :cars
  has_many   :self_drive_prices
  has_many   :locations, through: :self_drive_prices

  class << self
    def without_prices
      where(:self_drive_prices => {car_model_id: nil})
    end

    def with_prices
      where('self_drive_prices.car_model_id is not null')
    end

    def car_types
      @car_types ||= [['全部','']] + CarType.all.map{|c|[c.to_s, c.id]}
    end
    def prices_range
      %w/全部 100元以下 100-200元 200-300元 300元以上/
      .zip ['', "0...100", "100...200", "200...300", "300"]
    end

    def in(params)
      @@start_date = (Date.parse params[:start_date] rescue Date.today)
      @@end_date   = (Date.parse params[:end_date]   rescue Date.today)
      @@location   = Location.find(params[:location])
      @@car_models = @@location.car_models.includes(:self_drive_prices).with_prices
    end

    def car_model_list
      [['全部','']] + group('car_model').map{|c|[c.car_model, "#{c.car_model}—#{c.id}"]}
    end
  end

  def total_price
    prices_array.sum
  end

  def average_price
    "%.1f"%(total_price.to_f / prices_array.size)
  end

  def date_array
    (@@start_date .. @@end_date).to_a
  end

  def price
    @price ||= self_drive_prices.find_by_location_id @@location.id
  end

  def prices_array
    return @prices_array if @prices_array
    weekend_rate = price.weekend
    weekday_rate = price.weekday
    _hash = {}
    price.custom_prices.map{|c| _hash[Range.new(*c.range.split('-').map(&:to_date))] = c.price }

    @prices_array = date_array.map{|d| _hash.select{|k| d.in?(k)}.values.first || d }.map do |d|
      if d.kind_of? Date
        d.weekday? ? weekday_rate : weekend_rate
      else
        d #custom price
      end
    end
  end

  def price_info
    {
      total_price: self.total_price,
      average_price: self.average_price,
      prices_array: self.date_array.zip(self.prices_array)
    }
  end

  scope :prices_in, ->(text){
    range = eval(text)
    if range.kind_of? Range
      where(self_drive_prices: {weekday: range})
    else
      where("`self_drive_prices`.`weekday` >= ?",range)
    end
  }
  scope :car_model_equals, ->(car_model){
    where("car_model = ?",car_model.split('—').first)
  }

  search_method :prices_in, :car_model_equals


  def to_s
    car_model_name
  end  

  def self.car_model_atmt_list  
    %w/MT AT AMT/
    .zip ['手动','自动','手/自一体']
  end
  [:car_model_atmt].each do |name|   
    if /atmt$/ =~ name
      define_method "#{name}_text" do  
        return Hash[self.class.send "#{name}_list"][read_attribute(name.to_sym)]
      end 
    end
  end
  
end
