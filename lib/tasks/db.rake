#encoding: utf-8
Rake::TaskManager.record_task_metadata = true

namespace :db do
  desc '创建uploads文件夹,并建立软链接'
  task :storage => :environment do |task|
    puts task.comment

    require 'shell'

    web_names=%w/gcr-web www.zucheqq.com/
    admin_uploads_path="../../#{Rails.root.basename}/public/uploads/"

    sh = Shell.cd(Rails.root.join('public'))
    sh.transact do
      mkdir 'uploads' unless exists? 'uploads'
      cd '../../'
      web_names.select!{|d| exists? d}
      cd "#{web_names.first}/public"
      system *%w/rm -rf uploads/ if exists? 'uploads'
      system *%W(ln -s #{admin_uploads_path} ./)
    end
  end

  desc "执行迁移文件"
  task :create_database => :environment do |task|
    puts task.comment

    Rake::Task["db:migrate:reset"].invoke
  end

  desc "加载基础数据"
  task :load_data => :environment do |task|
    puts task.comment
    Rake::Task["db:seed"].invoke
  end

  desc "准备城市地区数据"
  task :city => :environment do |task|
    puts task.comment

    City.destroy_all
    open Rails.root.join('lib','tasks','sql','city.sql') do |f|
      ActiveRecord::Base.connection.execute(f.read)
    end

    District.destroy_all
    open Rails.root.join('lib','tasks','sql','district.sql') do |f|
      ActiveRecord::Base.connection.execute(f.read)
    end
  end

  task 'city:sz' => :environment do |task|
    City.destroy_all(City.arel_table[:city_name].not_eq('深圳市'))
  end

  desc "准备门店数据"
  task :location => :environment do |task|
    puts task.comment

    Location.destroy_all
    %w{北京市 深圳市}.each do |c|
      (City.find_by_city_name(c) or next).districts.map do |d|
        { city_id: d.city_id,
          district_id: d.id,
          location_name: "#{d}门店" }
      end.each do |l|
        Location.new(l).save(validate: false)
      end
    end

  end

  desc "准备机场数据"
  task :airport => :environment do |task|
    puts task.comment

    Airport.destroy_all
    open Rails.root.join('lib','tasks','sql','airport.sql') do |f|
      ActiveRecord::Base.connection.execute(f.read)
    end
  end

  desc "准备车站数据"
  task :railway => :environment do |task|
    puts task.comment

    Railway.destroy_all
    open Rails.root.join('lib','tasks','sql','railway.sql') do |f|
      ActiveRecord::Base.connection.execute(f.read)
    end
  end

  desc "准备车型数据"
  task :car_type => :environment do |task|
    puts task.comment

    CarType.destroy_all
    def image_file name
      return unless name
      asset_path=Rails.root.join('lib','assets')
      File.open(asset_path.join(name))
    end

    types=%w/舒适车型 商务车型 经济车型 豪华车型 家用车型/
    images=Dir.foreach(Rails.root.join('lib','assets')).to_a.grep(/cartype/).sort*2
    types.zip(images).each_with_index do |c,i|
      CarType.new do |cn|
        cn.id = i+1
        cn.car_type_name = c.first
        cn.image = image_file(c.last)
        cn.persons = 4
      end.save
    end
  end
  desc "准备车辆品牌数据"
  task :car_model => :environment do |task|
    puts task.comment

    CarModel.destroy_all
    open Rails.root.join('lib','tasks','sql','car_model.sql') do |f|
      ActiveRecord::Base.connection.execute(f.read)
    end
  end

  desc "准备车型价格数据"
  task :car_type_rate => :environment do |task|
    puts task.comment

    CarTypeRate.destroy_all
    sample = -> {
      [CarType.all.sample.id, BaseRateCode.dj.sample.id]
    }
    collestions=[]
    (CarType.count * BaseRateCode.dj.count).times do

      new = sample.call
      while collestions.include? new
        new = sample.call
      end
      collestions << new

      CarTypeRate.create(
        car_type_id: new.first,
        base_rate_code_id: new.last ,
        base_rate: Random.rand(1000) ,
        xhour: Random.rand(1000) ,
        xdis_rate: Random.rand(1000),
        prices_included: [:oil, :insure, :driver]#.sample(Random.rand(0..3))
      )
    end
  end

  desc "生成优惠码数据"
  task :coupon => :environment do |task|
    puts task.comment

    start_date=30.days.ago
    end_date=start_date + 100.days
    code="ABCD"
    Coupon.create(coupon_code: code, denomination: 100, start_date: start_date, end_date: end_date)
    # 50.times do
    #   start_date=Random.rand(-30..30).days.ago
    #   end_date=start_date + Random.rand(10..30).days
    #   code="YH#{Random.rand(10000..99999)}"
    #   coupon=Coupon.create(coupon_code: code, denomination: Random.rand(10..100), start_date: start_date, end_date: end_date)
    #   puts coupon.verfiy[:msg]
    # end

  end

  task 'coupon:clear' => :environment do |task|
    Coupon.destroy_all
  end

  desc "加载cms数据"
  task :cms => :environment do |task|
    puts task.comment

    Cms::Site.destroy_all
    site = Cms::Site.create!(
      identifier:  "zucheqq-admin",
      label:       "zucheqq",
      hostname:    "admin.zucheqq.com",
      path:        "",
      locale:      "zh-CN",
      is_mirrored: false,
    )

    site.snippets.create!(
      label: '页面布局底部',
      identifier: "footer",
      content: '<div class="wdj_foot"><p>版权所有：车联天下&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;技术支持：荣益信息科技
 © 2011-2013 www.zucheqq.com. All Rights Reserved.陕ICP备12002321号-10</p></div>'
    )
    site.snippets.create!(
      label: '租车服务条款',
      identifier: "agreement",
      content: "尊敬的客户你好！欢迎你来到车联天下租车！为了你的用车方便，也考虑到你的旅途劳累，如果你需要代驾业务，请授权我公司从代驾公司为你办理代驾司机业务，如果你同意请同意本条款，预祝你用车愉快！"
    )

    site.snippets.create!(
      label: '预定成功短信模板',
      identifier: "cms-template",
      content: %q{
<% case reservation.rate_code %>
<% when "RZ","SZ" %>
<%= "您的订单生成成功，订单号：#{reservation}，业务：#{reservation.base_rate_code}，城市：#{reservation.pickup_city}，车型：#{reservation.car_type}，上车时间：#{reservation.pickup_date}，详情请访问网站查询。" -%>
<% when "JJ","SJ" %>
<%= "您的订单生成成功，订单号：#{reservation}，业务：#{reservation.base_rate_code}，城市：#{reservation.pickup_city}，机场：#{reservation.airport}，航班号：#{reservation.airline}，车型：#{reservation.car_type}，用车时间：#{reservation.pickup_date}，详情请访问网站查询。" -%>
<% when "JHC","SHC" %>
<%= "您的订单生成成功，订单号：#{reservation}，业务：#{reservation.base_rate_code}，城市：#{reservation.pickup_city}，车站：#{reservation.railway}，车次：#{reservation.train_number}，车型：#{reservation.car_type}，用车时间：#{reservation.pickup_date}，详情请访问网站查询。" -%>
<% when "DDD" %>
<%= "您的订单生成成功，订单号：#{reservation}，业务：#{reservation.base_rate_code}，城市：#{reservation.pickup_city}，车型：#{reservation.car_type}，开始时间：#{reservation.pickup_date}，结束时间：#{reservation.return_date}，详情请访问网站查询。" -%>
<% when "ZJ" %>
<%= "您的订单生成成功，订单号：#{reservation}，业务：#{reservation.base_rate_code}，城市：#{reservation.pickup_city}，车
型：#{reservation.car_model}，取车门店：#{reservation.pickup_location},还车门店：#{reservation.return_location},开始时间：#{reservation.pickup_date}，结束时间：#{reservation.return_date}，详情请访问网站查询。" -%>
<% end %>
}
    )
    site.snippets.create!(
      label: 'android和iso客户端',
      identifier: "mobile-client",
      content: '<div class="wdj_middle_main_left_dvservice">
  <div class="wdj_middle_main_tit">
    <a href="#"></a><span>酒后代驾 / Driver Service</span>
  </div>
  <div class="wdj_middle_main_left_dvservice_main">
    <a class="wdj_iphone_icon"></a>
    <a class="wdj_android_icon" href=></a>
  </div>
</div>'
    )
  end

  desc "准备所有数据"
  task :all => [:create_database, :load_data, :car_type,
                :car_model, :car_type_rate, :city, :railway,
                :airport, :coupon, :storage, :cms, 'city:sz']

end
