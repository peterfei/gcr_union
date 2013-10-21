#coding: utf-8                                                                                                         
 class SmsApi < ActiveRecord::Base                                                                                       
   attr_accessible :phone_nums, :content, :company                                                                       
   default_scope :order => 'created_at DESC'                                                                             
   def self.send_sms_message(*args)                                                                                      
     easy = Curl::Easy.new                                                                                               
     content = easy.escape %Q/#{args.second}#{args.size>=3 ? "【#{args.last}】":nil}/                                    
     message_send_url = SysParameter.get_url + "sourceadd=&" + "phone=#{args.first}" + '&content=' + content             
                                                                                                                         
     logger.info "SMS sending..."                                                                                        
     logger.info Curl.get(message_send_url).body_str                                                                     
   end                                                                                                                   
 end 
