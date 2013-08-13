class SelfDrivePricesController < ApplicationController
  def index
    @search = SelfDrivePrice.search(params[:search])
    @self_drive_prices = @search.page params[:page]
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render_select2 @self_drive_prices }
    end
  end

  def new
  end

  # POST /self_drive_prices
  # POST /self_drive_prices.json
  def create
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
      params[:custome_date_range].zip(params[:custome_prices]).each do |range,_prices|
        _start, _end = range.split(' - ')
        _start = Date.parse(_start)
        _end   = Date.parse(_end)
        until _start > _end do
          prices << SelfDrivePrice.new(car_model_id: id,
                                       date: _start,
                                       rate: _prices,
                                       flag: :custome)
          _start += 1.days
        end
      end
    end
    respond_to do |format|
      if SelfDrivePrice.import prices
        format.html { redirect_to self_drive_prices_path }
      else
        format.js {render 'new'}
      end
    end
  end
end
