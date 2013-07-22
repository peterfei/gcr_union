# coding: utf-8
feature '建立加盟商' do
  scenario '访问company index' do 
    visit '/companies'
    #page.should have_content "你好加盟商"
  end
end
