class SelfDrivePricesController < ApplicationController
  # GET /self_drive_prices
  # GET /self_drive_prices.json
  layout 'index'
  def index
    @search = SelfDrivePrice.search(params[:search])
    @self_drive_prices=@search.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @self_drive_prices }
      format.js
    end
  end

  # GET /self_drive_prices/1
  # GET /self_drive_prices/1.json
  def show
    @self_drive_price = SelfDrivePrice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @self_drive_price }
    end
  end

  # GET /self_drive_prices/new
  # GET /self_drive_prices/new.json
  def new
    @self_drive_price = SelfDrivePrice.new
    @self_drive_price.custom_prices.build

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /self_drive_prices/1/edit
  def edit
    @self_drive_price = SelfDrivePrice.find(params[:id])
  end

  # POST /self_drive_prices
  # POST /self_drive_prices.json
  def create
    prices_params=params[:car_model_ids].split(',').map{|c| {car_model_id: c}.merge!(params[:self_drive_price])}

    self_drive_prices = SelfDrivePrice.create(prices_params)
    respond_to do |format|
      if self_drive_prices.map(&:errors).empty?
        format.html { redirect_to self_drive_prices_path, notice: 'Self drive price was successfully created.' }
      else
        format.html { redirect_to self_drive_prices_path, notice: self_drive_prices.map{|s|s.errors.messages.values}.flatten.join(',') }
      end
    end
  end

  # PUT /self_drive_prices/1
  # PUT /self_drive_prices/1.json
  def update
    @self_drive_price = SelfDrivePrice.find(params[:id])

    respond_to do |format|
      if @self_drive_price.update_attributes(params[:self_drive_price])
        format.html { redirect_to @self_drive_price, notice: 'Self drive price was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @self_drive_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /self_drive_prices/1
  # DELETE /self_drive_prices/1.json
  def destroy
    @self_drive_price = SelfDrivePrice.find(params[:id])
    @self_drive_price.destroy

    respond_to do |format|
      format.html { redirect_to self_drive_prices_url }
      format.json { head :no_content }
    end
  end
end
