# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :consultation do
    linkman "MyString"
    cons_rate "MyString"
    content "MyText"
    use_car_date "MyString"
    result "MyString"
    phone "MyString"
    rate_codes "MyString"
    rate_code_id 1
    car_model_code "MyString"
    consultation_type "MyString"
  end
end
