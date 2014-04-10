class SysParametersController < ApplicationController
  # GET /sys_parameters
  # GET /sys_parameters.json
  def index
    @sys_parameters = SysParameter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sys_parameters }
    end
  end

  # GET /sys_parameters/1
  # GET /sys_parameters/1.json
  def show
    @sys_parameter = SysParameter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sys_parameter }
    end
  end

  # GET /sys_parameters/new
  # GET /sys_parameters/new.json
  def new
    @sys_parameter = SysParameter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sys_parameter }
    end
  end

  # GET /sys_parameters/1/edit
  def edit
    @sys_parameter = SysParameter.find(params[:id])
  end

  # POST /sys_parameters
  # POST /sys_parameters.json
  def create
    @sys_parameter = SysParameter.new(params[:sys_parameter])

    respond_to do |format|
      if @sys_parameter.save
        format.html { redirect_to @sys_parameter, notice: '系统参数创建成功' }
        format.json { render json: @sys_parameter, status: :created, location: @sys_parameter }
      else
        format.html { render action: "new" }
        format.json { render json: @sys_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sys_parameters/1
  # PUT /sys_parameters/1.json
  def update
    @sys_parameter = SysParameter.find(params[:id])

    respond_to do |format|
      if @sys_parameter.update_attributes(params[:sys_parameter])
        format.html { redirect_to @sys_parameter, notice: '系统参数更新成功' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sys_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sys_parameters/1
  # DELETE /sys_parameters/1.json
  def destroy
    @sys_parameter = SysParameter.find(params[:id])
    @sys_parameter.destroy

    respond_to do |format|
      format.html { redirect_to sys_parameters_url }
      format.json { head :no_content }
    end
  end
end
