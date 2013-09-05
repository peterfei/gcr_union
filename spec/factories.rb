#encoding:utf-8
FactoryGirl.define do 
  factory :reservation do  
    id 1
    confirmation "RZ201307081234001"
    reservation_person_phone "18092058670"
    source_code "web"
    up_address "西安软件园"
    down_address "西安钟楼" 
    pickup_date  "2013-07-07 00:00:00"
    return_date  "2013-07-07 00:00:00"
    passenger_num 1
    status "waitexec" 
    base_rate_code_id 1 
    car_type_id 1 
    company_id 1 
    use_day 1
    use_hour 1 
    car_id 1
    driver_id 1
  end 
  factory :city do  
    city_name "深圳" 
    city_code 199
  end 
  
  factory :district do  
    district_code 1769
    district_name "罗湖区"
    city_id 199
  end 

  #更新订单门店信息
  #factory :reservation do 
  #  pickup_city_id 199 
  #  pickup_district_id 1769
  #  location_id 1
  #end 
  factory :manager_user do  
    login_name "admin" 
    password "admin"
  end
end


