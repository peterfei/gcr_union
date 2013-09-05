#encoding:utf-8
require 'spec_helper'

describe "配车配司机规则" do 
  before(:each) do  
    @car = FactoryGirl.create(:car)  

    @car_type = FactoryGirl.create(:car_type) 
    @base_rate= FactoryGirl.create(:base_rate_code)
    @car_type_rate = FactoryGirl.create(:car_type_rate)
    @location = FactoryGirl.create(:location)
    @driver = FactoryGirl.create(:driver)  
    @reservation = FactoryGirl.create(:reservation)
  end
  describe "配车配司机规则" do
    it "C照开7座以下" do 
         if @reservation.car_type.persons<=7
              @reservation.driver
           
         end 
    end
  end
end
