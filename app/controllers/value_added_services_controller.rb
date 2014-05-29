class ValueAddedServicesController < ApplicationController
  # GET /value_added_services
  # GET /value_added_services.json
  def index
    @search = ValueAddedService.search(params[:search])
    @value_added_services = @search.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @value_added_services }
    end
  end

  # GET /value_added_services/1
  # GET /value_added_services/1.json
  def show
    @value_added_service = ValueAddedService.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @value_added_service }
    end
  end

  # GET /value_added_services/new
  # GET /value_added_services/new.json
  def new
    @value_added_service = ValueAddedService.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @value_added_service }
    end
  end

  # GET /value_added_services/1/edit
  def edit
    @value_added_service = ValueAddedService.find(params[:id])
  end

  # POST /value_added_services
  # POST /value_added_services.json
  def create
    @value_added_service = ValueAddedService.new(params[:value_added_service])

    respond_to do |format|
      if @value_added_service.save
        format.html { redirect_to @value_added_service, notice: '增值服务创建成功' }
        format.json { render json: @value_added_service, status: :created, location: @value_added_service }
      else
        format.html { render action: "new" }
        format.json { render json: @value_added_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /value_added_services/1
  # PUT /value_added_services/1.json
  def update
    @value_added_service = ValueAddedService.find(params[:id])

    respond_to do |format|
      if @value_added_service.update_attributes(params[:value_added_service])
        format.html { redirect_to @value_added_service, notice: '增值服务更新成功' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @value_added_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /value_added_services/1
  # DELETE /value_added_services/1.json
  def destroy
    @value_added_service = ValueAddedService.find(params[:id])
    @value_added_service.status = @value_added_service.status.enable? ? :disable : :enable
    @value_added_service.save

    flash[:success] = "增值服务#{@value_added_service.status_text}成功"

    respond_to do |format|
      format.html { redirect_to value_added_services_url }
      format.json { head :no_content }
    end
  end
end
