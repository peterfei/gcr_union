require 'spec_helper'

describe "CallCenters" do
  describe "GET /call_centers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get call_centers_path
      response.status.should be(200)
    end
  end
end
