require 'spec_helper'

describe "call_centers/edit" do
  before(:each) do
    @call_center = assign(:call_center, stub_model(CallCenter))
  end

  it "renders the edit call_center form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", call_center_path(@call_center), "post" do
    end
  end
end
