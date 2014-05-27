#encoding:utf-8
class Reservation < ActiveRecord::Base
  attr_accessible :confirmation, :pickup_date,
    :reservation_person_phone, :return_date, :source_code,
    :status, :total_price, :send_address, :receiver, :receiver_phone,
    :special_passenger, :special_requirements, :up_address, :down_address,
    :up_construction, :down_construction, :remark, :rental_range,
    :use_day, :use_hour, :attachment, :passenger, :passenger_phone,
    :pickup_city_id, :return_city_id, :base_rate_code_id, :car_type_id,
    :invoice_title, :pickup_district_id, :return_district_id,
    :passenger_num, :airport_id, :railway_id, :airline, :coupon_id,
    :send_status, :car_id, :train_number, :car_model_id, :pay_mode,
    :return_location_id, :pickup_location_id,:company_id,:driver_id,
    :customer_id, :driver_attributes,
    :self_driving_prepayment, :self_driving_overtime, :self_driving_overdistance,
    :reservation_base_rate, :reservation_xdis_rate, :reservation_xhour

  default_scope ->{order("created_at DESC")}
  extend Enumerize

  serialize :special_passenger, Array
  serialize :special_requirements, Array
  enumerize :special_passenger, in: [:old, :patient, :baby, :pregnant, :foreign, :leader], multiple: true

  enumerize :status, in: [:unconfirm, :pending, :waitexec, :hascar, :execing, :done , :canceled],
    default: :unconfirm, predicates: true

  enumerize :pay_mode, in: [:online, :driver], default: :online

  # mount_uploader :attachment, AttachmentUploader

  belongs_to :car_type
  belongs_to :car_model
  belongs_to :car
  belongs_to :customer
  belongs_to :company
  belongs_to :driver
  belongs_to :base_rate_code
  accepts_nested_attributes_for :driver
  #belongs_to :location
  belongs_to :coupon
  belongs_to :base_rate_code

  belongs_to :pickup_city, class_name: 'City'
  belongs_to :return_city, class_name: 'City'
  belongs_to :pickup_district, class_name: 'District'
  belongs_to :return_district, class_name: 'District'
  belongs_to :pickup_location, class_name: 'Location'
  belongs_to :return_location, class_name: 'Location'

  belongs_to :airport
  belongs_to :railway
  has_one :comment
  validates :car_id, :presence => {message: '请选择车辆'},:if=>Proc.new{|r| r.status=='waitexec'}
  #validates :driver_id, :presence => {message: '请选择司机'},:if=>Proc.new{|r| r.status=='waitexec'}
  validates :use_day, :presence => {message: '用车天数不能为空'},
                      numericality: true,
                      :if => Proc.new { |r|
                        r.base_rate_code.rate_code=='RZ' }
  validates :use_hour, :presence => {message: '用车时长不能为空'},
                      numericality: true,
                      :if => Proc.new { |r| r.base_rate_code.rate_code=='SZ' }

  def value_added_services
    Hash[special_requirements.reject(&:blank?).map{|s|s.split('#')}]
  end
  def value_added_services_text
    ValueAddedService.where(id: value_added_services.keys).map(&:name).join('/')
  end
  def value_added_services_collection
    ValueAddedService.where(_type: rate_code == 'ZJ' ? 'self_driving' : 'reservation')
      .select{|v| v.status.enable? || value_added_services.has_key?(v.id.to_s)}
      .map do |v|
        price = value_added_services[v.id.to_s] || v.price
        ["#{v.name}(¥#{price})", "#{v.id}##{price}"]
      end
  end
  def value_added_servies_price
    value_added_services.inject(0){|sum, v| sum += v.last.to_f }
  end

  def rate_code
    @rate_code ||= base_rate_code.rate_code
  end

  def rate_code= rate_code
    @rate_code=rate_code
  end

  def unit
    {
      'RZ' => '天',
      'SZ' => '小时'
    }.fetch base_rate_code.rate_code,'趟'
  end
  #def car_type_id 
  #   car_type_id||car_model.car_type.car_type_id
  #end
  def car_type_rate
    CarTypeRate.find_by_base_rate_code_id_and_car_type_id base_rate_code_id,car_type_id
  end
  def pickup_city_id
    read_attribute(:pickup_city_id)||read_attribute(:return_city_id)
  end

  def pickup_district_id
    read_attribute(:pickup_district_id)||read_attribute(:return_district_id)
  end

  def pickup_location_id
    read_attribute(:pickup_location_id)||read_attribute(:return_location_id)
  end
  # before_save :compute_price
  before_create :generate_confirmation
  def compute_price
    if rate_code == 'ZJ'

    else
      price = car_type_rate.base_rate

      if rate_code=='RZ'
        price = use_day * car_type_rate.base_rate
      elsif rate_code=='SZ'
        price = use_hour * car_type_rate.base_rate
      end

      price += Settings.en_driver_prices if special_requirements.include?(:en_driver)
      price += Settings.wait_card_prices if special_requirements.include?(:waiting_card)
      price -= coupon.denomination if coupon
    end
    write_attribute :total_price, price
  end
  #订单状态流转
  def flow(status)
    case status
    when 'pending'
      update_attribute :status,:waitexec
    when 'waitexec'
      update_attribute :status,:hascar
    when 'hascar'
      update_attribute :status,:execing
    when 'execing'
      update_attribute :status,:done
    when 'cancel'
      update_attribute :status,:canceled
    end
  end
  def generate_confirmation
    write_attribute :confirmation, "#{base_rate_code.rate_code}#{Time.now.strftime('%Y%m%d%H%M%S%L')}"
  end
  
  composed_of :pickup_date,
    :class_name => 'CompoundDatetime',
    :mapping => [ %w(pickup_date datetime) ],
    :converter => Proc.new { |datetime| CompoundDatetime.from_datetime(datetime) }
  composed_of :return_date,
    :class_name => 'CompoundDatetime',
    :mapping => [ %w(return_date datetime) ],
    :converter => Proc.new { |datetime| CompoundDatetime.from_datetime(datetime) }
   
  def self_drive_price
    SelfDrivePrice.find_by_car_model_id_and_location_id car_model_id, pickup_location_id
  end
  
  #def reservation_person_phone
  #  read_attribute(:reservation_person_phone)||self.customer.user.phone
  #end
  def sms 
    view = ActionView::Base.new(ActionController::Base.view_paths, {})
    template = view.render(inline: "#{Cms::Snippet.find_by_identifier('cms-template').content}", locals: {reservation: self})
    SmsApi.send_sms_message(self.pickup_location.principal_phone ,template,'荣益科技')
  end
  def to_s 
    confirmation
  end 

  def starting_point
    if rate_code == 'JJ'
      "#{pickup_city} #{airport}"
    elsif rate_code == 'JHC'
      "#{pickup_city} #{railway}"
    else
      "#{pickup_city} #{pickup_district} #{up_address} #{up_construction}"
    end
  end

  def destination
    if rate_code == 'SJ'
      "#{return_city} #{airport}"
    elsif rate_code == 'SHC'
      "#{return_city} #{railway}"
    else
      "#{return_city} #{return_district} #{down_address} #{down_construction}"
    end
  end

end

