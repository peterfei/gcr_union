require 'spec_helper'

describe "black_records/index" do
  before(:each) do
    assign(:black_records, [
      stub_model(BlackRecord,
        :name => "Name",
        :phone => "Phone",
        :email => "Email",
        :cid => "Cid",
        :status => 1,
        :deleted => 2,
        :remark => "MyText"
      ),
      stub_model(BlackRecord,
        :name => "Name",
        :phone => "Phone",
        :email => "Email",
        :cid => "Cid",
        :status => 1,
        :deleted => 2,
        :remark => "MyText"
      )
    ])
  end

  it "renders a list of black_records" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Cid".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
