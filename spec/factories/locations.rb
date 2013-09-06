FactoryGirl.define do  
  factory :location,class:"Location"  do   
      id 1
      address "address" 
      city_id 1
      district_id 1
      end_time '17:30'
      start_time "08:00" 
      is24 "0" 
      location_name "location" 
      status "enable" 
      company_id 1 
      phone "18092068790" 
      principal "zhang" 
      principal_phone "18092068790"
  end
end
