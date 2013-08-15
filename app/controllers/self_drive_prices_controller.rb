class SelfDrivePricesController < ApplicationController
  skip_load_resource
  def index
    @search = SelfDrivePrice.search(params[:search])
    @self_drive_prices = @search.page params[:page]
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @self_drive_prices }
    end
  end

  def show
    @self_drive_prices = SelfDrivePrice.prices_for(params[:id])
  end

  def new
    @self_drive_price = SelfDrivePrice.new
  end

  def edit
    @self_drive_prices = SelfDrivePrice.prices_for(params[:id])
    respond_to do |format|
      format.js
      format.html # index.html.erb
    end
  end

  def update
    SelfDrivePrice.prices_for(params[:car_model_ids]).destroy_all
    respond_to do |format|
      if SelfDrivePrice.import _create
        format.html { redirect_to self_drive_prices_path }
      else
        format.js {render 'new'}
      end
    end
  end

  # POST /self_drive_prices
  # POST /self_drive_prices.json
  def create
    SelfDrivePrice.prices_for(params[:car_model_ids]).destroy_all
    respond_to do |format|
      if SelfDrivePrice.import _create
        format.html { redirect_to self_drive_prices_path }
      else
        format.js {render 'new'}
      end
    end
  end
  private
  def _create
    prices = []
    params[:car_model_ids].split(',').each do |id|
      weekday_prices=params[:weekday_prices]
      weekend_prices=params[:weekend_prices]
      prices << SelfDrivePrice.new(car_model_id: id,
                                   rate: weekday_prices,
                                   flag: :weekday)
      prices << SelfDrivePrice.new(car_model_id: id,
                                   rate: weekend_prices,
                                   flag: :weekend)
      prices += SelfDrivePrice.range_insert(params.merge(car_model_id: id))
    end
    prices
  end
end
