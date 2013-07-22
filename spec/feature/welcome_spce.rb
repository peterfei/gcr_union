# coding: utf-8
feature '初次访问' do
  scenario '访问welcome 控制器' do
    visit '/welcome'
    #page.should have_content "你好"
  end 
  context "1" do 
    pending
  end 
  context "2" do 
  end
end
