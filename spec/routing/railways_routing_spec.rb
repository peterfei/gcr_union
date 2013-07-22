require "spec_helper"

describe RailwaysController do
  describe "routing" do

    it "routes to #index" do
      get("/railways").should route_to("railways#index")
    end

    it "routes to #new" do
      get("/railways/new").should route_to("railways#new")
    end

    it "routes to #show" do
      get("/railways/1").should route_to("railways#show", :id => "1")
    end

    it "routes to #edit" do
      get("/railways/1/edit").should route_to("railways#edit", :id => "1")
    end

    it "routes to #create" do
      post("/railways").should route_to("railways#create")
    end

    it "routes to #update" do
      put("/railways/1").should route_to("railways#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/railways/1").should route_to("railways#destroy", :id => "1")
    end

  end
end
