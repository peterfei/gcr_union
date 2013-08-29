# coding: utf-8
class CarModel < ActiveRecord::Base
  attr_accessible :car_model, :car_model_atmt, :car_model_code, :car_model_img_url, :car_model_name, :car_model_package, :car_model_size, :car_model_type, :car_type_code, :status, :car_type_id

 # mount_uploader :car_model_img_url, CompanyLogoUploader

  mount_uploader :car_model_img_url, AttachmentUploader
  has_many :cars
  belongs_to :car_type
  has_many :self_drive_prices

  def self.without_prices
    includes(:self_drive_prices).where(:self_drive_prices => {car_model_id: nil})
  end

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
