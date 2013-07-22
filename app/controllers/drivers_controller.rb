# coding: utf-8
class DriversController < ApplicationController
  # GET /drivers
  # GET /drivers.json
  def index
    @search = Driver.search(params[:search])
    @drivers=@search.page params[:page]

    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render_select2 @drivers, text:'driver_name'}
    end
  end

  # GET /drivers/1
  # GET /drivers/1.json
  def show
    @driver = Driver.find(params[:id])

    respond_to do |format|
      #format.html # show.html.erb
      format.js
      format.json { render_select2 @driver, text: 'driver_name' }
    end
  end

  # GET /drivers/new
  # GET /drivers/new.json
  def new
    @driver = Driver.new

    respond_to do |format| 
      format.js
      format.html # new.html.erb
      format.json { render json: @driver }
    end
  end

  # GET /drivers/1/edit
  def edit
    @driver = Driver.find(params[:id])
  end

  # POST /drivers
  # POST /drivers.json
  def create
    @driver = Driver.new(params[:driver])

    respond_to do |format|
      if @driver.save
        format.html { redirect_to @driver, notice: '驾驶员添加成功' }
        format.json { render json: @driver, status: :created, location: @driver }
      else
        format.html { render action: "new" }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /drivers/1
  # PUT /drivers/1.json
  def update
    @driver = Driver.find(params[:id])

    respond_to do |format|
      if @driver.update_attributes(params[:driver])
        format.html { redirect_to @driver, notice: 'Driver was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drivers/1
  # DELETE /drivers/1.json
  def destroy
    @driver = Driver.find(params[:id])
    @driver.destroy

    respond_to do |format|
      #format.html { redirect_to drivers_url }
      format.js
      format.json { head :no_content }
    end
  end

  def change_status
    @driver = Driver.find(params[:id])

    respond_to do |format|
      if @driver.status=='在租'
        @driver.update_attribute(:status, 1)
      else
        @driver.update_attribute(:status, 0)
      end
      #format.html { redirect_to drivers_url }
      format.js
      format.json { head :no_content }
    end
  end
end
