#encoding:utf-8
class UserSessionsController < ApplicationController
	def new 
    respond_to do |format|
      format.html {render :layout=>false}
    end
	end

  def create 
    user = ManagerUser.find_by_login_name(params[:login]) 
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
