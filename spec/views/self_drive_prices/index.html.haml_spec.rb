require 'spec_helper'

describe "self_drive_prices/index" do
  before(:each) do
    assign(:self_drive_prices, [
      stub_model(SelfDrivePrice,
        :weekday => "9.99",
        :weekend => "9.99",
        :car_model => nil,
        :location => nil,
        :prepayment => "9.99",
        :overtime => "9.99",
        :overdistance => "9.99"
      ),
      stub_model(SelfDrivePrice,
        :weekday => "9.99",
        :weekend => "9.99",
        :car_model => nil,
        :location => nil,
        :prepayment => "9.99",
        :overtime => "9.99",
        :overdistance => "9.99"
      )
    ])
  end

  it "renders a list of self_drive_prices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
