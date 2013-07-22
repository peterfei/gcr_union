require "spec_helper"

describe ManagerUsersController do
  describe "routing" do

    it "routes to #index" do
      get("/manager_users").should route_to("manager_users#index")
    end

    it "routes to #new" do
      get("/manager_users/new").should route_to("manager_users#new")
    end

    it "routes to #show" do
      get("/manager_users/1").should route_to("manager_users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/manager_users/1/edit").should route_to("manager_users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/manager_users").should route_to("manager_users#create")
    end

    it "routes to #update" do
      put("/manager_users/1").should route_to("manager_users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/manager_users/1").should route_to("manager_users#destroy", :id => "1")
    end

  end
end
