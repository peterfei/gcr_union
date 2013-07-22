require "spec_helper"

describe PhoneValidatesController do
  describe "routing" do

    it "routes to #index" do
      get("/phone_validates").should route_to("phone_validates#index")
    end

    it "routes to #new" do
      get("/phone_validates/new").should route_to("phone_validates#new")
    end

    it "routes to #show" do
      get("/phone_validates/1").should route_to("phone_validates#show", :id => "1")
    end

    it "routes to #edit" do
      get("/phone_validates/1/edit").should route_to("phone_validates#edit", :id => "1")
    end

    it "routes to #create" do
      post("/phone_validates").should route_to("phone_validates#create")
    end

    it "routes to #update" do
      put("/phone_validates/1").should route_to("phone_validates#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/phone_validates/1").should route_to("phone_validates#destroy", :id => "1")
    end

  end
end
