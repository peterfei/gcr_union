#encoding:utf-8
require 'spec_helper'
describe  "用户登陆" do
    subject {page} 
     describe "登陆页面" do  
      before {visit  '/signin'}
      it{should have_content('用户名')}
      it{should have_title('华夏通联加盟商管理平台')} 
      describe "登陆失败页面提示错误信息" do  
        before {click_button "submit"} 
        it {should have_content('登陆')} 
        it {should have_selector('div.alert-messages .alert.alert-error',text:"登陆失败")}
      end 
      describe '用户填入信息登陆' do   
        let(:user) {FactoryGirl.create(:manager_user)}
        before do  
            fill_in "[login]",with:user.login_name
            fill_in "[password]",with:user.password
            click_button "submit"
        end 
        it {should_not have_link('登陆')}
        it {should have_link('注销')}
      end
     end 
end
