FactoryGirl.define do  
  factory :base_rate_code,class:"BaseRateCode" do   
    id 1
    base_hour 5
    base_km 100
    rate_code "RZ" 
    rate_code_name "RZ"
  end
end
