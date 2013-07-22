require "spec_helper"

describe BaseRateCodesController do
  describe "routing" do

    it "routes to #index" do
      get("/base_rate_codes").should route_to("base_rate_codes#index")
    end

    it "routes to #new" do
      get("/base_rate_codes/new").should route_to("base_rate_codes#new")
    end

    it "routes to #show" do
      get("/base_rate_codes/1").should route_to("base_rate_codes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/base_rate_codes/1/edit").should route_to("base_rate_codes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/base_rate_codes").should route_to("base_rate_codes#create")
    end

    it "routes to #update" do
      put("/base_rate_codes/1").should route_to("base_rate_codes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/base_rate_codes/1").should route_to("base_rate_codes#destroy", :id => "1")
    end

  end
end
