class CarModelsController < ApplicationController
  # GET /car_models
  # GET /car_models.json
  def index
    @search = CarModel.search(params[:search])
    @car_models = @search.page params[:page]

    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render_select2 @car_models }
    end
  end

  # GET /car_models/1
  # GET /car_models/1.json
  def show
    @car_model = CarModel.find(params[:id])

    respond_to do |format|
      format.js
      format.html # show.html.erb
      format.json { render_select2 @car_model }
    end
  end

  # GET /car_models/new
  # GET /car_models/new.json
  def new
    @car_model = CarModel.new

    respond_to do |format|
      format.js
      format.html # new.html.erb
      format.json { render json: @car_model }
    end
  end

  # GET /car_models/1/edit
  def edit
    @car_model = CarModel.find(params[:id])
  end

  # POST /car_models
  # POST /car_models.json
  def create
    @car_model = CarModel.new(params[:car_model])

    respond_to do |format|
      if @car_model.save
        @search = CarModel.search(params[:search])
        @car_models = @search.page params[:page]
        format.html { redirect_to @car_model, notice: '车辆品牌新建成功' }
        format.json { render json: @car_model, status: :created, location: @car_model }
      else
        format.html { render action: "new" }
        format.json { render json: @car_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /car_models/1
  # PUT /car_models/1.json
  def update
    @car_model = CarModel.find(params[:id])

    respond_to do |format|
      if @car_model.update_attributes(params[:car_model])
        format.html { redirect_to @car_model, notice: 'Car model was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @car_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /car_models/1
  # DELETE /car_models/1.json
  def destroy
    @car_model = CarModel.find(params[:id])

    @car_model.status = @car_model.status.enable? ? :disable : :enable
    @car_model.save

    respond_to do |format|
      format.html { redirect_to car_models_url }
      format.js { render 'status_changed' }
    end
  end
end
