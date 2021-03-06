# coding: utf-8
class DriversController < ApplicationController
  # GET /drivers
  # GET /drivers.json
  def index
    @search = Driver.search(params[:search])
    if current_user.role=='oprator' 
      @where = "#{current_user.company_id}" 
      @drivers=@search.where(:company_id=>@where).page params[:page]
    else
      @drivers=@search.page params[:page]
    end
    #@drivers=initialize_grid(@search.page params[:page])
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render_select2 @drivers,'driver_phone','driver_allowed', text:'driver_name'}
    end
  end

  # GET /drivers/1
  # GET /drivers/1.json
  def show
    @driver = Driver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render_select2 @driver, 'driver_phone','driver_allowed',text: 'driver_name' }
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
    driver = params[:drivers].first
    drivers_params=params[:drivers].map{|d| driver.merge(d)}
    logger.info "------#{drivers_params}"
    @drivers = Driver.create(drivers_params)
    respond_to do |format|
      if @drivers.map{|c| c.errors.messages}.all?(&:empty?)
        flash[:success] = '司机新建成功'
        format.js
      else
        format.js {render 'error_msg'}
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
      if @driver.status=='enable'
        @driver.update_attribute(:status, 'disable')
      else
        @driver.update_attribute(:status, 'enable')
      end
      #format.html { redirect_to drivers_url }
      format.js
      format.json { head :no_content }
    end
  end
end
