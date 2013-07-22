require "spec_helper"

describe CarTypeRatesController do
  describe "routing" do

    it "routes to #index" do
      get("/car_type_rates").should route_to("car_type_rates#index")
    end

    it "routes to #new" do
      get("/car_type_rates/new").should route_to("car_type_rates#new")
    end

    it "routes to #show" do
      get("/car_type_rates/1").should route_to("car_type_rates#show", :id => "1")
    end

    it "routes to #edit" do
      get("/car_type_rates/1/edit").should route_to("car_type_rates#edit", :id => "1")
    end

    it "routes to #create" do
      post("/car_type_rates").should route_to("car_type_rates#create")
    end

    it "routes to #update" do
      put("/car_type_rates/1").should route_to("car_type_rates#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/car_type_rates/1").should route_to("car_type_rates#destroy", :id => "1")
    end

  end
end
