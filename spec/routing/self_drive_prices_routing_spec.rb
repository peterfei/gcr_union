require "spec_helper"

describe SelfDrivePricesController do
  describe "routing" do

    it "routes to #index" do
      get("/self_drive_prices").should route_to("self_drive_prices#index")
    end

    it "routes to #new" do
      get("/self_drive_prices/new").should route_to("self_drive_prices#new")
    end

    it "routes to #show" do
      get("/self_drive_prices/1").should route_to("self_drive_prices#show", :id => "1")
    end

    it "routes to #edit" do
      get("/self_drive_prices/1/edit").should route_to("self_drive_prices#edit", :id => "1")
    end

    it "routes to #create" do
      post("/self_drive_prices").should route_to("self_drive_prices#create")
    end

    it "routes to #update" do
      put("/self_drive_prices/1").should route_to("self_drive_prices#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/self_drive_prices/1").should route_to("self_drive_prices#destroy", :id => "1")
    end

  end
end
