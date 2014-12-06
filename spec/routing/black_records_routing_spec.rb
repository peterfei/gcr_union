require "spec_helper"

describe BlackRecordsController do
  describe "routing" do

    it "routes to #index" do
      get("/black_records").should route_to("black_records#index")
    end

    it "routes to #new" do
      get("/black_records/new").should route_to("black_records#new")
    end

    it "routes to #show" do
      get("/black_records/1").should route_to("black_records#show", :id => "1")
    end

    it "routes to #edit" do
      get("/black_records/1/edit").should route_to("black_records#edit", :id => "1")
    end

    it "routes to #create" do
      post("/black_records").should route_to("black_records#create")
    end

    it "routes to #update" do
      put("/black_records/1").should route_to("black_records#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/black_records/1").should route_to("black_records#destroy", :id => "1")
    end

  end
end
