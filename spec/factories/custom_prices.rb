# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :custom_price do
    range "MyString"
    self_drive_price nil
    price "9.99"
  end
end
