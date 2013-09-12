# coding: utf-8
class CarsController < ApplicationController 
  # GET /cars
  # GET /cars.json
  def index
      @search = Car.search(params[:search]) 
    if current_user.role=='oprator'  
      @where = current_user.company.locations.pluck(:id) 
      @cars = @search.where("location_id in (?)",@where).page params[:page]
    else
      @cars=@search.page params[:page]
    end
    respond_to do |format|
      format.js
      format.html # index.html.erb 
      format.json { render_select2 @cars, text:'car_tag'}
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show 
    @car = Car.find(params[:id])

    respond_to do |format|
      format.js
      format.html # show.html.erb 
      format.json { render_select2 @car, text: 'car_tag' }
    end
  end

  # GET /cars/new
  # GET /cars/new.json
  def new
    @car = Car.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @car }
    end
  end

  # GET /cars/1/edit
  def edit
    @car = Car.find(params[:id])
  end

  # POST /cars
  # POST /cars.json
  def create
    cars_params=params[:cars].map{|c| c.merge!(params[:car])}
    @cars =Car.create(cars_params)
    respond_to do |format|  
      if  @cars.map{|c| c.errors.full_messages}==[[]]
        format.js  
      else
        format.js {render 'error_msg'}
      end
    end
  end

  # PUT /cars/1
  # PUT /cars/1.json
  def update
    @car = Car.find(params[:id])
    respond_to do |format|  
      if @car.update_attributes(params[:car])
        format.html { redirect_to @car, notice: '车辆信息更新成功.' }
        format.json { head :no_content } 
        format.js 
      else 
        format.js {render 'new'}
        format.html { render action: "edit" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car = Car.find(params[:id])

    respond_to do |format|
      @car.update_attribute(:status, 'disable')
      format.html { redirect_to cars_url }
      format.js
      format.json { head :no_content }
    end
  end
end
