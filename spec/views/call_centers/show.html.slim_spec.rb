require 'spec_helper'

describe "call_centers/show" do
  before(:each) do
    @call_center = assign(:call_center, stub_model(CallCenter))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
