#encoding:utf-8
FactoryGirl.define do 
   factory :driver,class:"Driver" do   
      id 1
      driver_name "zhang" 
      driver_phone "18892058670" 
      status "enable" 
      company_id 1
      location_id  1
      driver_allowed "C1" 
      driver_year 1
      born "1988-08-18"
   end
end
