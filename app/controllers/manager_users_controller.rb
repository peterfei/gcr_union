class ManagerUsersController < ApplicationController
  # GET /manager_users
  # GET /manager_users.json
  def index
    @search = ManagerUser.search(params[:search])
    @manager_users = @search.page params[:page]
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @manager_users }
    end
  end

  # GET /manager_users/1
  # GET /manager_users/1.json
  def show
    @manager_user = ManagerUser.find(params[:id])

    respond_to do |format| 
      format.js
      format.json { render json: @manager_user }
      format.html
    end
  end

  # GET /manager_users/new
  # GET /manager_users/new.json
  def new
    @manager_user = ManagerUser.new

    respond_to do |format| 
      format.js
      format.html # new.html.erb
      format.json { render json: @manager_user }
    end
  end

  # GET /manager_users/1/edit
  def edit
    @manager_user = ManagerUser.find(params[:id]) 
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /manager_users
  # POST /manager_users.json
  def create
    params[:manager_user][:permission]=params[:manager_user][:permission].reject(&:empty?).join(',')
    # params[:manager_user]=
    @manager_user = ManagerUser.new(params[:manager_user])

    respond_to do |format|
      if @manager_user.save
        format.html { redirect_to @manager_user, notice: '管理用户创建成功.' }
        format.json { render json: @manager_user, status: :created, location: @manager_user }
      else 
        format.js{render "new"}
        format.html { render action: "new" }
        format.json { render json: @manager_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /manager_users/1
  # PUT /manager_users/1.json
  def update
    @manager_user = ManagerUser.find(params[:id]) 
    unless params[:manager_user][:password].present?
       params[:manager_user].delete(:password)
    end
    params[:manager_user][:permission]=params[:manager_user][:permission].reject(&:empty?).join(',')
    respond_to do |format| 
      if @manager_user.update_attributes(params[:manager_user])
        format.html { redirect_to @manager_user, notice: '管理用户更新成功.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @manager_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manager_users/1
  # DELETE /manager_users/1.json
  def destroy
    @manager_user = ManagerUser.find(params[:id])
    @manager_user.destroy

    respond_to do |format|
      format.html { redirect_to manager_users_url }
      format.json { head :no_content }
    end
  end
end
