class CallCentersController < ApplicationController
  # GET /call_centers
  # GET /call_centers.json
  def index
    @call_centers = CallCenter.all

    respond_to do |format|
      format.html  { render :layout => false}
      format.json { render json: @call_centers }
    end
  end
  
  def consultation  

    params[:reservation]||={} unless params[:reservation].present?
    unless params[:reservation][:base_rate_code_id].present? 
      if params[:self_driving].present?
        params[:reservation] = params[:self_driving] 
      end
    end  

    params[:reservation][:base_rate_code_id]||=BaseRateCode.first.id
    params[:reservation][:reservation_person_phone]||=params[:callInNo] 
    #@customer = Customer.find_by_phone(params[:callInNo]) 
    #params[:reservation][:reservation_customer_id]||=@customer.id 
    @reservation = Reservation.new(params[:reservation]) 
    if @reservation.rate_code=='ZJ' 
      @reservation = SelfDriving.new(params[:reservation])
    end 
    @history = Reservation.where(:reservation_person_phone => params[:callInNo])
    @user = User.find_by_phone(params[:callInNo])
    respond_to do |format|
      format.js 
      format.html  { render :layout => 'call_center'}
      format.json { render json:{total_price:(@reservation.compute_price rescue 0) ,base_rate:(@reservation.car_type_rate rescue 0),special_requirements:(@reservation.special_requirements rescue nil)}}
    end
    #render :layout=>'call_center'
  end
  # GET /call_centers/1
  # GET /call_centers/1.json
  def show
    @call_center = CallCenter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @call_center }
    end
  end

  # GET /call_centers/new
  # GET /call_centers/new.json
  def new
    @call_center = CallCenter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @call_center }
    end
  end

  # GET /call_centers/1/edit
  def edit
    @call_center = CallCenter.find(params[:id])
  end

  # POST /call_centers
  # POST /call_centers.json
  def create
    @reservation = Reservation.new(params[:reservation])

    respond_to do |format| 
      if @reservation.save  
        @search= Reservation.search params[:search]
        if current_user.role=='oprator'  
          @where = current_user.company.locations.pluck(:id) 
          @reservations= @search.where("pickup_location_id in (?) ",@where).page params[:page] 
        else
          @reservations= @search.page params[:page]
        end  
        format.js
        #format.json { render json: @reservation, status: :created, location: @call_center }
      else 
        format.js{render 'consultation.js.erb'}
        format.html { render action: "new" }
        format.json { render json: @call_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /call_centers/1
  # PUT /call_centers/1.json
  def update
    @call_center = CallCenter.find(params[:id])

    respond_to do |format|
      if @call_center.update_attributes(params[:call_center])
        format.html { redirect_to @call_center, notice: 'Call center was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @call_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /call_centers/1
  # DELETE /call_centers/1.json
  def destroy
    @call_center = CallCenter.find(params[:id])
    @call_center.destroy

    respond_to do |format|
      format.html { redirect_to call_centers_url }
      format.json { head :no_content }
    end
  end 

  def flights  
    @flight= GcrWeb::Flight.find('ca1888')
    respond_to do |format|
      format.json {render json: @flight.flight}
    end
  end
end
