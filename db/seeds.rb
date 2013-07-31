#encoding:utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

BaseRateCode.destroy_all
BaseRateCode.create([
  {rate_code: 'JJ', rate_code_name: "接机", base_hour: 1, base_km: 1}, 
  {rate_code: 'SJ', rate_code_name: "送机", base_hour: 1, base_km: 1}, 
  {rate_code: 'JHC', rate_code_name: "接火车", base_hour: 1, base_km: 1}, 
  {rate_code: 'SHC', rate_code_name: "送火车", base_hour: 1, base_km: 1}, 
  {rate_code: 'RZ', rate_code_name: "日租", base_hour: 1, base_km: 1}, 
  {rate_code: 'SZ', rate_code_name: "时租", base_hour: 1, base_km: 1},
  {rate_code: 'DDD', rate_code_name: "定制", base_hour: 1, base_km: 1}
])

SysParameter.destroy_all
SysParameter.create([
  {para_id:1,para_name:'MESSAGE_URL',para_value:'http://www.stongnet.com/sdkhttp/sendsms.aspx',para_desc:''},
  {para_id:2,para_name:'MESSAGE_PARAM',para_value:'reg=101100-WEB-HUAX-757650&pwd=AICGGVJI&',para_desc:''},
  {para_id:3,para_name:'MESSAGE_CONTENT',para_value:'',para_desc:''},
  {para_id:4,para_name:'MAIL_HOST',para_value:'www.rongyitech.com',para_desc:'发送邮件服务器'},
  {para_id:5,para_name:'MAIL_PORT',para_value:'25',para_desc:'smpT发送邮件服务port'},
  {para_id:6,para_name:'MAIL_USERNAME',para_value:'mailtest@rongyitech.com',para_desc:'发送邮件账号'},
  {para_id:7,para_name:'MAIL_PASSWORD',para_value:'123456',para_desc:'发送邮件账号的密码'},
  {para_id:8,para_name:'MAIL_AUTH',para_value:'true',para_desc:''},
  {para_id:9,para_name:'MAIL_TIMEOUT',para_value:'25000',para_desc:''}
])

Location.destroy_all
Location.create([
  {location_name:"罗湖总店",city_id:4403,district_id:440303},
  {location_name:"罗湖分店1",city_id:4403,district_id:440304},
  {location_name:"罗湖分店2",city_id:4403,district_id:440305}
])
Car.destroy_all 
location_id=Location.find_by_location_name('罗湖总店').id
Car.create([
  {location_id:location_id,car_tag:"粤E74110",status:'Y'},
  {location_id:location_id,car_tag:"粤E74112",status:'Y'},
])
ManagerUser.new(
  login_name:'admin',
  password: 'admin',
  role:'admin'
).save validate:false

