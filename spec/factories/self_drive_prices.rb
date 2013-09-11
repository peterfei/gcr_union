# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :self_drive_price do
    weekday "9.99"
    weekend "9.99"
    car_model nil
    location nil
    prepayment "9.99"
    overtime "9.99"
    overdistance "9.99"
  end
end
