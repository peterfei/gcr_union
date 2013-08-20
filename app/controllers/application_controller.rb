#endoding:utf-8
class ApplicationController < ActionController::Base  
  include UserSessionsHelper
  include ApplicationHelper

  before_filter  :need_sign_in
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :flash =>{:error=>"auth error!"}
  end 
  protect_from_forgery  
  skip_load_and_authorize_resource unless: :do_not_check_authorization?

  private

  def do_not_check_authorization?
    controller_path.include? 'cms_admin' or controller_path.include? 'cms_content'
  end   
end
