#encoding:utf-8
class UsersController < ApplicationController
  before_filter :need_sign_in, :only => [:show, :edit, :update]
  
  def index
      @search = User.search params[:search]
      @users = @search.page params[:page]
  end 

  def new
    @user = User.new 
    respond_to do |format| 
      format.js
      format.html{render:'_form',:layout=>false}
    end
  end

  def show
    @user=User.find params[:id]
    respond_to do |format|   
      format.js
    end
  end

  def create
    @user = User.new(params[:user])
    @user.uuid = SecureRandom.uuid

    respond_to do |format|
      if @user.save
        login_as @user
        flash.now[:success] = "注册成功"
        format.js
        format.json { render json: @user }
      else
        format.js { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find params[:id]
    respond_to do |format| 
      format.js
    end
  end

  def update
    @user = User.find params[:id] 
    unless params[:user][:password].present?  
       params[:user].delete params[:user][:password]
    end
    respond_to do |format| 
      if @user.update_attributes(params[:user]) 
        flash.now[:success]='用户数据更新成功'
      else
        flash.now[:error]='用户数据更新失败'
      end
      
      format.js
    end
  end 
  def change_user_status  
    @user = User.find params[:id] 
    respond_to do |format|  
      if @user.status=='disable'  
        @user.update_attribute(:status,:enable)
      else  
        @user.update_attribute(:status,:disable)
      end 
      format.js
    end
  end
end
