#encoding:utf-8
class ReservationsController < ApplicationController 
  # GET /reservations
  # GET /reservations.json
  def index  
    if current_user.role=='oprator' 
      @where = current_user.company.locations.pluck(:id) 
      @search = Reservation.search(params[:search]).where("location_id in (?)",@where) 
    else  
      @search = Reservation.search(params[:search]) 
    end
    @reservations= @search.page params[:page]
    respond_to do |format| 
      format.js
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    @reservation = Reservation.find(params[:id])

    respond_to do |format| 
      format.js
      #format.html # show.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/new
  # GET /reservations/new.json
  def new
    @reservation = Reservation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/1/edit
  def edit
    @reservation = Reservation.find(params[:id])  
    respond_to do |format| 
      format.js
    end
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(params[:reservation])

    respond_to do |format|
      if @reservation.save 
        format.js
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render json: @reservation, status: :created, location: @reservation }
      else 
        format.js
        format.html { render action: "new" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reservations/1
  # PUT /reservations/1.json
  def update
    @reservation = Reservation.find(params[:id])
    respond_to do |format| 
      if @reservation.update_attributes(params[:reservation])
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { head :no_content }
      else 
        format.js {render 'new'}
        format.html { render action: "edit" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
    end
  end 

  #分配门店
  def dispatch_location   
    @reservation = Reservation.find(params[:id])  
    respond_to do |format|  
    @o =false
     if request.put? 
        @o = @reservation.update_attributes(params[:reservation])  

        @reservation.flow("pending")
     end 

      format.js 
    end 
  end 

  #分配车辆牌照 
  def dispatch_car  
    @reservation = Reservation.find(params[:id])
    respond_to do |format|  
    $o =false
     if request.put?  
        $o = @reservation.update_attributes(params[:reservation])   
        @reservation.car.update_attribute(:status,'disable')  
        @reservation.driver.update_attribute(:status,'disable')
        @reservation.flow("waitexec")
      #  SmsApi.send_sms_message(@reservation.reservation_person_phone,"已为您的订单#{@reservation.confirmation}分配好车辆和司机,车牌号:#{@reservation.car.car_tag}")
     end 
      format.js 
    end 
  end 
  #执行订单 
  def execing  
    @reservation = Reservation.find(params[:id]) 
    @reservation.flow("hascar") 
    respond_to do |format|
      #format.html { redirect_to reservations_url, notice: '订单执行成功.' }
      format.js
    end
  end
  #完成订单 
  def done 
    @reservation = Reservation.find(params[:id]) 
    @reservation.flow("execing")  
    @reservation.car.update_attribute(:status,'enable')
    @reservation.driver.update_attribute(:status,'enable')
    respond_to do |format| 
      format.js{render 'execing.js.erb'}
      #format.html { redirect_to reservations_url, notice: '订单执行成功.' }
    end
  end
  #取消订单 
  def cancel
    @reservation = Reservation.find(params[:id])  
    @reservation.car.update_attribute(:status,'enable') if @reservation.car 
    @reservation.driver.update_attribute(:status,'enable') if @reservation.driver
    @reservation.flow("cancel") 
    respond_to do |format| 
      format.js{render 'execing.js.erb'}
      #format.html { redirect_to reservations_url, notice: '订单执行成功.' }
    end
  end
end
