#endoding:utf-8
class ApplicationController < ActionController::Base  
  include UserSessionsHelper
  include ApplicationHelper

  before_filter  :need_sign_in
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :flash =>{:error=>"auth error!"}
  end 
  protect_from_forgery  
   
end
