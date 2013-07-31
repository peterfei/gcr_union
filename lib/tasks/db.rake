#encoding: utf-8
Rake::TaskManager.record_task_metadata = true

namespace :db do
  desc '创建uploads文件夹,并建立软链接'
  task :storage => :environment do |task|
    puts task.comment

    web_name   = 'gcr-web'
    admin_name = Rails.root.basename

    web_public_path=File.expand_path("../#{web_name}/public",Rails.root)
    admin_uploads_path="../../#{admin_name}/public/uploads/"

    `cd #{Rails.root.join('public')}
     [ ! -d "uploads" ] && mkdir uploads/
     cd #{web_public_path}
     [ -d "uploads" ] && rm -rf uploads
     ln -s #{admin_uploads_path} ./
    `
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
      [CarType.all.sample.id, BaseRateCode.all.sample.id]
    }
    collestions=[]
    (CarType.count * BaseRateCode.count).times do

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


  desc "准备所有数据"
  task :all => [:create_database, :load_data, :car_type,
                :car_model, :car_type_rate, :city, :railway,
                :airport, :coupon, :storage]

end
