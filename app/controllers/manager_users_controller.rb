class ManagerUsersController < ApplicationController
  # GET /manager_users
  # GET /manager_users.json
  def index
    @manager_users = ManagerUser.all

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
    end
  end

  # POST /manager_users
  # POST /manager_users.json
  def create
    @manager_user = ManagerUser.new(params[:manager_user])

    respond_to do |format|
      if @manager_user.save
        format.html { redirect_to @manager_user, notice: 'Manager user was successfully created.' }
        format.json { render json: @manager_user, status: :created, location: @manager_user }
      else
        format.html { render action: "new" }
        format.json { render json: @manager_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /manager_users/1
  # PUT /manager_users/1.json
  def update
    @manager_user = ManagerUser.find(params[:id])
    if params[:manager_user][:password].present?
       params[:manager_user].delete(:password)
    end
    respond_to do |format|
      if @manager_user.update_attributes(params[:manager_user])
        format.html { redirect_to @manager_user, notice: 'Manager user was successfully updated.' }
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
