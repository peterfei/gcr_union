class CarTypesController < ApplicationController
  # GET /car_types
  # GET /car_types.json
  def index
    @car_types = CarType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @car_types }
    end
  end

  # GET /car_types/1
  # GET /car_types/1.json
  def show
    @car_type = CarType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @car_type }
    end
  end

  # GET /car_types/new
  # GET /car_types/new.json
  def new
    @car_type = CarType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @car_type }
    end
  end

  # GET /car_types/1/edit
  def edit
    @car_type = CarType.find(params[:id])
  end

  # POST /car_types
  # POST /car_types.json
  def create
    @car_type = CarType.new(params[:car_type])

    respond_to do |format|
      if @car_type.save
        format.html { redirect_to @car_type, notice: 'Car type was successfully created.' }
        format.json { render json: @car_type, status: :created, location: @car_type }
      else
        format.html { render action: "new" }
        format.json { render json: @car_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /car_types/1
  # PUT /car_types/1.json
  def update
    @car_type = CarType.find(params[:id])

    respond_to do |format|
      if @car_type.update_attributes(params[:car_type])
        format.html { redirect_to @car_type, notice: 'Car type was successfully updated.' }
        format.json { head :no_content }
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
    end
  end
end
