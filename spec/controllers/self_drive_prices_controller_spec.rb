require 'spec_helper'

describe SelfDrivePricesController do

  describe "GET 'date:date'" do
    it "returns http success" do
      get 'date:date'
      response.should be_success
    end
  end

  describe "GET 'rate:decimal'" do
    it "returns http success" do
      get 'rate:decimal'
      response.should be_success
    end
  end

  describe "GET 'car_model:references'" do
    it "returns http success" do
      get 'car_model:references'
      response.should be_success
    end
  end

  describe "GET 'location:references'" do
    it "returns http success" do
      get 'location:references'
      response.should be_success
    end
  end

  describe "GET 'flag:string'" do
    it "returns http success" do
      get 'flag:string'
      response.should be_success
    end
  end

end
