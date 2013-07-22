require "spec_helper"

describe ShunfengchesController do
  describe "routing" do

    it "routes to #index" do
      get("/shunfengches").should route_to("shunfengches#index")
    end

    it "routes to #new" do
      get("/shunfengches/new").should route_to("shunfengches#new")
    end

    it "routes to #show" do
      get("/shunfengches/1").should route_to("shunfengches#show", :id => "1")
    end

    it "routes to #edit" do
      get("/shunfengches/1/edit").should route_to("shunfengches#edit", :id => "1")
    end

    it "routes to #create" do
      post("/shunfengches").should route_to("shunfengches#create")
    end

    it "routes to #update" do
      put("/shunfengches/1").should route_to("shunfengches#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/shunfengches/1").should route_to("shunfengches#destroy", :id => "1")
    end

  end
end
