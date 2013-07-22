#encoding:utf-8
class UserSessionsController < ApplicationController
	def new 
    respond_to do |format|
      format.html {render :layout=>false}
    end
	end

  def create 
    #user = User.find_by_username(params[:username]) 
    #if user && user.authenticate(params[:password])
    if params[:login]=='admin' && params[:password]=='admin'
    #  login_as user 
    #  @user = user
      #respond_to do |format|  
      #  flash.now[:success] = "登陆成功"
      #  format.js
      #end
      redirect_to reservations_path
    else

      respond_to do |format| 
        flash[:error] = "登陆失败,请重新登陆" 
        format.html {redirect_to :back}
      end
    end
  end

	def destroy
		logout
    flash[:success] = 'Logout Successfully'
		redirect_to root_path
	end

end
