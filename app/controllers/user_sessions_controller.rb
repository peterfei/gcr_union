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
      if user.role=='oprator' && user.company.status==1
        flash[:error] = "该账号已停用，登录失败" 
        redirect_to root_path 
        return 
      end
      login_as user 
      respond_to do |format| 
        format.html {redirect_to reservations_path}# index.html.erb
        format.json { render json: user }
      end
    else
      flash.now[:error] = "登陆失败,请重新登陆" 
      respond_to do |format| 
        format.html {redirect_to root_path}# index.html.erb
        format.json { render json:  -1}
      end
        #render 'new'
        #format.html {redirect_to :back}
    end
  end

	def destroy
		logout
    flash[:success] = '登出成功'
		redirect_to root_path
	end

end
