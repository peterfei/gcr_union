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
  end

  def create
    @user = User.new(params[:user])
    @user.uuid = SecureRandom.uuid

    respond_to do |format|
      if @user.save
        flash.now[:success] = "注册成功"
        format.html
        format.json { render json: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    unless params[:user][:password].present?
      params[:user].delete params[:user][:password]
    end
      if @user.update_attributes(params[:user])
        flash[:success]='用户数据更新成功'
        redirect_to @user
      else
        flash[:error]='用户数据更新失败'
        render :edit
      end
  end
  def change_user_status
    @user = User.find params[:id]
    respond_to do |format|
      if @user.status.disable?
        @user.update_attribute(:status,:enable)
      else
        @user.update_attribute(:status,:disable)
      end
      format.js
    end
  end
end
