# coding: utf-8
class SmsApi < ActiveRecord::Base
  attr_accessible :phone_nums, :content, :company
  default_scope :order => 'created_at DESC'  
  def self.send_sms_message(phone_nums, content, company) 
    message_send_url = SysParameter.get_url  + "sourceadd=" + '&' + "phone=#{phone_nums}" + '&' + "content=#{content}【#{company}】"
    #message_send_url = SysParameter.get_url  + '&' + "phone=#{phone_nums}" + '&' + "content=#{content}【#{company}】"

    # message_send_url = SysParameter.get_url + '&' + "sourceadd=#{company}" + '&' + "phone=#{phone_nums.join(',')}" + '&' + "content=#{content}【#{company}】"
    logger.info ' * SMS_API*'+message_send_url
    Curl.get(message_send_url)
    #create(phone_nums: phone_nums, content: content, company: company)
  end
  
end
