require 'spec_helper'

describe "self_drive_prices/show" do
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

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
  end
end
