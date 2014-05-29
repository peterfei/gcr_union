#encoding:utf-8
class CarTypeRatesController < ApplicationController
  # GET /car_type_rates
  # GET /car_type_rates.json
  def index
    @search = CarTypeRate.includes(:base_rate_code,:car_type,:city).search(params[:search])
    @car_type_rates = @search.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @car_type_rates }
      format.js
    end
  end

  # GET /car_type_rates/1
  # GET /car_type_rates/1.json
  def show
    @car_type_rate = CarTypeRate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @car_type_rate }
      format.js
    end
  end

  # GET /car_type_rates/new
  # GET /car_type_rates/new.json
  def new
    @car_type_rate = CarTypeRate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @car_type_rate }
    end
  end

  # GET /car_type_rates/1/edit
  def edit
    @car_type_rate = CarTypeRate.find(params[:id])
  end

  # POST /car_type_rates
  # POST /car_type_rates.json
  def create
    @car_type_rate = CarTypeRate.new(params[:car_type_rate])

    respond_to do |format|
      if @car_type_rate.save
        format.html { redirect_to @car_type_rate, notice: '车型价格生成成功！' }
        format.json { render json: @car_type_rate, status: :created, location: @car_type_rate }
      else
        format.html { render action: "new" }
        format.json { render json: @car_type_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /car_type_rates/1
  # PUT /car_type_rates/1.json
  def update
    @car_type_rate = CarTypeRate.find(params[:id])

    respond_to do |format|
      if @car_type_rate.update_attributes(params[:car_type_rate])
        format.html { redirect_to @car_type_rate, notice: 'Car type rate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @car_type_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /car_type_rates/1
  # DELETE /car_type_rates/1.json
  def destroy
    @car_type_rate = CarTypeRate.find(params[:id])
    @car_type_rate.destroy

    respond_to do |format|
      format.html { redirect_to car_type_rates_url }
      format.json { head :no_content }
    end
  end
end
