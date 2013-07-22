# coding: utf-8
feature '建立订单信息' do 
  let(:reservation) {FactoryGirl.build(:reservation,status:2)}
  let(:city) {FactoryGirl.build(:city)}
  let(:district) {FactoryGirl.build(:district)}
  scenario '访问reservation index' do
    visit '/reservations'
    #page.should have_content "你好加盟商"
  end  
  context "对订单进行分配" do 
    it  "更新订单状态由待处理转化为待执行" do     
      expect{reservation.flow("pending")}.to change{reservation.status}.from("pending").to("waitexec") 
    end    
  end
  context '订单进行配车' do   
    #visit '/reservations/1/dispatch_car/' 
    it "订单状态由待执行转化为已配车" do 
      expect{reservation.flow("waitexec")}.to change{reservation.status}.from("waitexec").to("hascar") 
    end
  end 
  context "执行订单" do  
    it "订单状态由已配车到执行中" do  
      expect{reservation.flow("hascar")}.to change{reservation.status}.from("hascar").to("execing") 
    end
  end
  context "完成该订单" do  
    it "订单状态由执行中已完成" do  
      expect{reservation.flow("execing")}.to change{reservation.status}.from("execing").to("done") 
    end
  end
end
