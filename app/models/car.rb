# coding: utf-8
class Car < ActiveRecord::Base
  attr_accessible :car_tag, :color, :status, :receive_model,
    :location_id, :car_type_id, :car_model_id, :driver_id,
    :seat, :alt_car_tag

  validates :car_tag, presence: { message: '不能为空' }, uniqueness: {message:"已占用"}
  validates :location_id, presence: true
  validates :car_model_id, presence: true

  extend Enumerize
  enumerize :status, in: [:enable,:disable], default: :enable

  belongs_to :location
  belongs_to :car_model
  belongs_to :car_type

  def to_s
    car_tag
  end
  def car_model_name
    car_model.car_model_name
  end
  def self.available car_type_id,seat
    where(car_type_id:car_type_id)
  end

  before_save :car_type_wr
  def car_type_wr
    write_attribute :car_type_id, car_model.car_type_id
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      product.attributes = row.to_hash.slice(*accessible_attributes)
      product.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "不支持的文件类型: #{file.original_filename}"
    end
  end
end
