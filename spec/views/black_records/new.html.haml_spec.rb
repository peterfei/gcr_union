require 'spec_helper'

describe "black_records/new" do
  before(:each) do
    assign(:black_record, stub_model(BlackRecord,
      :name => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :cid => "MyString",
      :status => 1,
      :deleted => 1,
      :remark => "MyText"
    ).as_new_record)
  end

  it "renders new black_record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", black_records_path, "post" do
      assert_select "input#black_record_name[name=?]", "black_record[name]"
      assert_select "input#black_record_phone[name=?]", "black_record[phone]"
      assert_select "input#black_record_email[name=?]", "black_record[email]"
      assert_select "input#black_record_cid[name=?]", "black_record[cid]"
      assert_select "input#black_record_status[name=?]", "black_record[status]"
      assert_select "input#black_record_deleted[name=?]", "black_record[deleted]"
      assert_select "textarea#black_record_remark[name=?]", "black_record[remark]"
    end
  end
end
