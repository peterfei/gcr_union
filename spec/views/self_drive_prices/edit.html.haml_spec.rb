require 'spec_helper'

describe "self_drive_prices/edit" do
  before(:each) do
    @self_drive_price = assign(:self_drive_price, stub_model(SelfDrivePrice,
      :weekday => "9.99",
      :weekend => "9.99",
      :car_model => nil,
      :location => nil,
      :prepayment => "9.99",
      :overtime => "9.99",
      :overdistance => "9.99"
    ))
  end

  it "renders the edit self_drive_price form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", self_drive_price_path(@self_drive_price), "post" do
      assert_select "input#self_drive_price_weekday[name=?]", "self_drive_price[weekday]"
      assert_select "input#self_drive_price_weekend[name=?]", "self_drive_price[weekend]"
      assert_select "input#self_drive_price_car_model[name=?]", "self_drive_price[car_model]"
      assert_select "input#self_drive_price_location[name=?]", "self_drive_price[location]"
      assert_select "input#self_drive_price_prepayment[name=?]", "self_drive_price[prepayment]"
      assert_select "input#self_drive_price_overtime[name=?]", "self_drive_price[overtime]"
      assert_select "input#self_drive_price_overdistance[name=?]", "self_drive_price[overdistance]"
    end
  end
end
