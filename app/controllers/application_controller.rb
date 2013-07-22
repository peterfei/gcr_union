#endoding:utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  include UserSessionsHelper
  include ApplicationHelper
end
