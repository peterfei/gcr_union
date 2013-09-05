#encoding:utf-8
FactoryGirl.define do 
   factory :car,class:"Car" do  
      car_tag "粤A8888" 
      color "红" 
      status "enable" 
      receive_model "C1" 
      location_id 1 
      car_type_id 1
      car_model_id 1
      driver_id 1
      seat 1
   end
end
