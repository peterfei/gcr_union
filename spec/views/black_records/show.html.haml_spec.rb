require 'spec_helper'

describe "black_records/show" do
  before(:each) do
    @black_record = assign(:black_record, stub_model(BlackRecord,
      :name => "Name",
      :phone => "Phone",
      :email => "Email",
      :cid => "Cid",
      :status => 1,
      :deleted => 2,
      :remark => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Phone/)
    rendered.should match(/Email/)
    rendered.should match(/Cid/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
  end
end
