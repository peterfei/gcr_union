# coding: utf-8
class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    @search = Location.search(params[:search])
    @locations=@search.page params[:page]

    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render_select2 @locations, text:'location_name'}
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      #format.html # show.html.erb
      format.js
      format.json { render_select2 @location, text: 'location_name' }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new

    respond_to do |format|
      #format.html # new.html.erb
      format.js
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id]) 
    respond_to do |format|
      format.js # new.html.erb
      format.json { render json: @location }
    end
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])

    @rate_code_list = ""
    if params[:location][:rate_code_list].present?
      params[:location][:rate_code_list].each do |value|
        if value!=""
          @rate_code_list+=value+"-"
        end
      end
      params[:location][:rate_code_list] = @rate_code_list
    end

    respond_to do |format|
      if @location.save 
        format.js
        format.html { redirect_to @location, notice: '门店信息建立成功.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    @rate_code_list = ""
    if params[:location][:rate_code_list].present?
      params[:location][:rate_code_list].each do |value|
         if value!=""
          @rate_code_list+=value+"|"
         end
      end
      params[:location][:rate_code_list] = @rate_code_list
    end

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: '门店信息更新成功.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.js
      #format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
end
