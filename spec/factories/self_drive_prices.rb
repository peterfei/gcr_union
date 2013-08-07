# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :self_drive_price, :class => 'SelfDrivePrices' do
    date "2013-08-07"
    rate "9.99"
    car_model nil
    location nil
    flag "MyString"
  end
end
