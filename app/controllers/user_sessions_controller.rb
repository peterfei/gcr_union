#encoding:utf-8
class UserSessionsController < ApplicationController 
   skip_load_and_authorize_resource 
   skip_before_filter :need_sign_in
	def new 
    respond_to do |format|
      format.html {render :layout=>false}
    end
	end

  def create 
    user = ManagerUser.find_by_login_name(params[:login]) 
    logger.info "UserSessionsController::#{user.to_json}"
    if user && user.authenticate(params[:password])
      login_as user 
      redirect_to reservations_path
    else
        flash.now[:error] = "登陆失败,请重新登陆" 
        render 'new'
        #format.html {redirect_to :back}
    end
  end

	def destroy
		logout
    flash[:success] = 'Logout Successfully'
		redirect_to root_path
	end

end
