# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :black_record do
    name "MyString"
    phone "MyString"
    email "MyString"
    cid "MyString"
    status 1
    deleted 1
    remark "MyText"
  end
end
