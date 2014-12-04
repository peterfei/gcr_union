#encoding:utf-8
class ReservationsController < ApplicationController
  # GET /reservations
  # GET /reservations.json
  def index
    @search = Reservation.search(params[:search])
    if current_user.role=='oprator'
      @where = current_user.company.locations.pluck(:id)
      @reservations= @search.where("pickup_location_id in (?) ",@where).page params[:page]
    elsif current_user.role=='distributor'
      @where = Location.where("company_id in (?)", current_user.permission.split(',').map(&:to_i)).pluck(:id)
      @reservations= @search.where("pickup_location_id in (?) ",@where).page params[:page]
    else
      @reservations= @search.page params[:page]
    end
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
    if @reservation.rate_code=='ZJ'
      @reservation= SelfDriving.find(params[:id])
    end
    respond_to do |format| 
      format.js
      format.html
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

  #分配订单功能 
  def dispatch_order
    @reservation = Reservation.find(params[:id]) 
    _hash = {};
    respond_to do |format|  
    @o =false
     if request.put? 
      _hash[:instead_order] ={
              :book_name=>(@reservation.customer.customer_name rescue nil),#订车人姓名，必填
              :book_phone =>(@reservation.customer.user.phone rescue nil),#订车人手机，必填
              :use_name =>(@reservation.customer.customer_name rescue nil),#用车人姓名，必填
              :use_phone=>(@reservation.customer.user.phone rescue nil),#用车人手机，必填
              :service_type=>(@reservation.base_rate_code.rate_code rescue nil),#业务类型，必填
              :re_car_model_id=>params[:car_model_api],#预定车型id，必填
              :re_car_model=>'',#预定车型名称，必填
              :passengers=>0,#乘客数，（超过7座的车型，乘客数为必填项）
              :if_payment=>0,#是否需要支付定金，必填
              :account_payment=>0,#订单结算方式，必填
              :deposit_payment=>0,#定金支付方式，必填
              :deposit_status=>0,#定金支付状态，必填
              :need_pay_deposit=>0,#需支付定金金额，必填
              :re_base_price=>(@reservation.reservation_base_rate rescue nil),#基价，必填
              #(@reservation.car_type_rate.xdis_rate rescue @reservation.self_drive_price.overdistance),#基价，必填
              # :car_model_name=>(@reservation.car_model.car_model_name rescue nil),
              # :car_type_name=>(@reservation.car_type.car_type_name rescue nil),
              #:xdis_rate=>(@reservation.car_type_rate.xdis_rate rescue @reservation.self_drive_price.overdistance),
              :re_base_hour=>(@reservation.base_rate_code.base_hour rescue nil),#基本小时，必填
              :re_base_km=>(@reservation.base_rate_code.base_km rescue nil),#基本公里，必填
              :re_outhour_uprice=>(@reservation.car_type_rate.xhour rescue @reservation.self_drive_price.overtime rescue nil),#超小时单价，必填
              :re_outkm_uprice=>(@reservation.car_type_rate.xdis_rate rescue @reservation.self_drive_price.overdistance),#超公里单价，必填
              :pre_order_cost=>(@reservation.total_price rescue 0)
              # :reservation_person_phone=>(@reservation.customer.user.phone rescue nil)
            }
        _hash[:instead_order_travel] = {
              :up_time =>(@reservation.pickup_date.to_s rescue nil),
              :down_time =>(@reservation.return_date.to_s rescue nil),
              :up_place=>"#{@reservation.pickup_city}#{@reservation.pickup_district}#{@reservation.up_address}",
              :down_place=>"#{@reservation.return_city}#{@reservation.return_district}#{@reservation.down_address}",
              :days=>@reservation.use_day,
              :flight_train=>@reservation.airline||@reservation.train_number
        }
        _hash["uu"]= {"uuid"=>"2a93bdc4-cb28-3664-ac78-7a701d658564"}
        
        _order = Api::Platforms.create(_hash)
        if _order
          @o=true
          @reservation.flow("hascar")  
        end
        #_order.attributes['order_number']
        # @o = @reservation.update_attributes(params[:reservation])  

        # @reservation.flow("pending")
     end 

      format.js 
    end
  end

  def dispatch_car_model
    @dispicher_ip = Company.find(params[:search][:company_id_equals]).dispicher_ip rescue nil
    #http://117.34.66.7:7072/api/car_types/all
    respond_to do |format|  
      format.json { render_select2 Api::CarType.all,'name', text:'name'}
    end
  end
  #分配车辆牌照 
  def dispatch_car  
    @reservation = Reservation.find(params[:id])
    #hot_fix delete seat in reservation 
    respond_to do |format|  
    $o =false
     if request.put?   
       params[:reservation].delete('seat')
       $o = @reservation.update_attributes(params[:reservation])   
       unless @reservation.base_rate_code.rate_code=='ZJ' 
         @reservation.driver.update_attribute(:status,'disable')  rescue nil
       end
        @reservation.car.update_attribute(:status,'disable')  rescue nil 
        #同步入crs-admin 数据库 
        if current_user.role=='oprator'   
          @dispicher_ip =  current_user.company.dispicher_ip rescue nil
          if @dispicher_ip.present?  
            _hash={:rate_code=>(@reservation.base_rate_code.rate_code rescue nil),:car_model_name=>(@reservation.car_model.car_model_name rescue nil),:car_type_name=>(@reservation.car_type.car_type_name rescue nil),:reservation_person=>(@reservation.customer.customer_name rescue nil),:xdis_rate=>(@reservation.car_type_rate.xdis_rate rescue @reservation.self_drive_price.overdistance),:xhour=>(@reservation.car_type_rate.xhour rescue @reservation.self_drive_price.overtime rescue nil),:hour_free=>(@reservation.base_rate_code.base_hour rescue nil),:dis_free=>(@reservation.base_rate_code.base_km rescue nil),:reservation_person_phone=>(@reservation.customer.user.phone rescue nil)}
            
            #分配订单
            CrsAdmin::Reservation.site= @dispicher_ip
            CrsAdmin::Reservation.create(@reservation.attributes.merge(_hash))
          end
        end
        #订单分配后，给加盟商发送预定成功信息
        @reservation.sms
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

    unless @reservation.base_rate_code.rate_code=='ZJ'
      @reservation.driver.update_attribute(:status,'enable')
    end
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

  def print
    @reservation = Reservation.find(params[:id]) 
    if @reservation.rate_code=='ZJ'
      @reservation= SelfDriving.find(params[:id])
    end
    respond_to do |format| 
      format.html{render :layout=>'print'}
    end
  end
end
