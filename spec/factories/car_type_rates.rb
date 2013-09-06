FactoryGirl.define do  
  factory :car_type_rate,class:"CarTypeRate" do 
    id 1
    base_rate 100
    xdis_rate 100
    xhour 100
    prices_included ["oil"]
    car_type_id 1
    base_rate_code_id 1
  end
end
