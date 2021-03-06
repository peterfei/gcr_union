class CarTypesController < ApplicationController
  # GET /car_types
  # GET /car_types.json
  def index
    @search = CarType.includes(:car_type_rates).search(params[:search])
    @car_types = @search.group('car_types.id').page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render_select2 @car_types }
      format.js
    end
  end

  # GET /car_types/1
  # GET /car_types/1.json
  def show
    @car_type = CarType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render_select2 @car_type }
      format.js
    end
  end

  # GET /car_types/new
  # GET /car_types/new.json
  def new
    @car_type = CarType.new
    BaseRateCode.dj.each do |rate_code|
      @car_type.car_type_rates.build do |c|
        c.base_rate_code_id = rate_code.id
        c.base_rate         = 0
        c.xdis_rate         = 0
        c.xhour             = 0
        c.prices_included   = [:oil, :insure, :driver]
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /car_types/1/edit
  def edit
    @car_type = CarType.find(params[:id])
  end

  # POST /car_types
  # POST /car_types.json
  def create
    city_id = params[:pickup_city]
    params[:car_type][:car_type_rates_attributes] = params[:car_type][:car_type_rates_attributes].map{|k,v| v.merge(:city_id=>city_id)}
    @car_type = CarType.new(params[:car_type])

    respond_to do |format|
      if @car_type.save
        format.html { redirect_to car_types_path }
        format.json { render json: @car_type, status: :created, location: @car_type }
      else
        format.html { render action: "new" }
        format.json { render json: @car_type.errors, status: :unprocessable_entity }
        format.js {render 'new'}
      end
    end
  end

  # PUT /car_types/1
  # PUT /car_types/1.json
  def update
    @car_type = CarType.find(params[:id])
    city_id = params[:pickup_city]
    params[:car_type][:car_type_rates_attributes] = params[:car_type][:car_type_rates_attributes].map{|k,v| v.merge(:city_id=>city_id)}
    respond_to do |format|
      if @car_type.update_attributes(params[:car_type])
        format.html { redirect_to car_types_path, notice: '更新成功' }
        format.json { head :no_content }
        format.js { render 'show' }
      else
        format.html { render action: "edit" }
        format.json { render json: @car_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /car_types/1
  # DELETE /car_types/1.json
  def destroy
    @car_type = CarType.find(params[:id])
    @car_type.destroy

    respond_to do |format|
      format.html { redirect_to car_types_url }
      format.json { head :no_content }
      format.js { redirect_to car_types_path }
    end
  end
end
