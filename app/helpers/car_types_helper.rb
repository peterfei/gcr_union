module CarTypesHelper 
  def get_city_id args 
    CarTypeRate.find_by_car_type_id(args).city_id rescue nil
  end
end
