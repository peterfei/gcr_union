# coding: utf-8
class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    @search = Location.includes(:company).search(params[:search])
    if current_user.role=='oprator'
      @where = "#{current_user.company_id}"
      @locations=@search.where(:company_id=>@where).page params[:page] 
    else
      @locations=@search.page params[:page]
    end
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render_select2 @locations, text: :display_name}
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])
    start_time = @location.start_time
    end_time = @location.end_time

    @start_time_hour = start_time.split(':')[0]
    @start_time_min = start_time.split(':')[1]
    @end_time_hour = end_time.split(':')[0]
    @end_time_min = end_time.split(':')[1]
    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render_select2 @location, text: 'location_name' }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    if current_user.role=='oprator'
      @location = Location.new(company_id:current_user.company_id) 
    else
      @location = Location.new
    end
    #默认营业时间
    @start_time_hour = '08'
    @start_time_min = '30'
    @end_time_hour = '17'
    @end_time_min = '30'
    @location.status = 1

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
    start_time = @location.start_time
    end_time = @location.end_time

    @start_time_hour = start_time.split(':')[0]
    @start_time_min = start_time.split(':')[1]
    @end_time_hour = end_time.split(':')[0]
    @end_time_min = end_time.split(':')[1]

    respond_to do |format|
      format.html
      format.js # new.html.erb
      format.json { render json: @location }
    end
  end

  # POST /locations
  # POST /locations.json
  def create
    start_time = "#{params[:start_time_hour]}:#{params[:start_time_min]}"
    end_time = "#{params[:end_time_hour]}:#{params[:end_time_min]}"
    if params[:location].present?
      params[:location][:start_time] = start_time
      params[:location][:end_time] = end_time
    end
    @location = Location.new(params[:location])
    
    respond_to do |format|
      if @location.save
        format.js
        format.html { redirect_to @location, notice: '门店信息建立成功.' }
        format.json { render json: @location, status: :created, location: @location }
      else 
        format.js {render 'new'}
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id]) 
    start_time = @location.start_time
    end_time = @location.end_time

    @start_time_hour = start_time.split(':')[0]
    @start_time_min = start_time.split(':')[1]
    @end_time_hour = end_time.split(':')[0]
    @end_time_min = end_time.split(':')[1]
    respond_to do |format|
      start_time = "#{params[:start_time_hour]}:#{params[:start_time_min]}"
      end_time = "#{params[:end_time_hour]}:#{params[:end_time_min]}"
      if params[:location].present?
        params[:location][:start_time] = start_time
        params[:location][:end_time] = end_time
      end 

      if @location.update_attributes(params[:location])
        format.js
        format.json { head :no_content }
      else 

        format.js{render 'new'}
        format.html { redirect_to edit_location_path(params[:id]) }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])

    @location.status = @location.status.enable? ? :disable : :enable
    @location.save

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.js { render 'status_changed' }
    end
  end
end
