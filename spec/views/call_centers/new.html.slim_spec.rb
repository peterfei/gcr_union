require 'spec_helper'

describe "call_centers/new" do
  before(:each) do
    assign(:call_center, stub_model(CallCenter).as_new_record)
  end

  it "renders new call_center form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", call_centers_path, "post" do
    end
  end
end
