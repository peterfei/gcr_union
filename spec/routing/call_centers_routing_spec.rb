require "spec_helper"

describe CallCentersController do
  describe "routing" do

    it "routes to #index" do
      get("/call_centers").should route_to("call_centers#index")
    end

    it "routes to #new" do
      get("/call_centers/new").should route_to("call_centers#new")
    end

    it "routes to #show" do
      get("/call_centers/1").should route_to("call_centers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/call_centers/1/edit").should route_to("call_centers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/call_centers").should route_to("call_centers#create")
    end

    it "routes to #update" do
      put("/call_centers/1").should route_to("call_centers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/call_centers/1").should route_to("call_centers#destroy", :id => "1")
    end

  end
end
