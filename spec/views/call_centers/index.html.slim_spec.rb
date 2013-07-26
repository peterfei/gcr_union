require 'spec_helper'

describe "call_centers/index" do
  before(:each) do
    assign(:call_centers, [
      stub_model(CallCenter),
      stub_model(CallCenter)
    ])
  end

  it "renders a list of call_centers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
