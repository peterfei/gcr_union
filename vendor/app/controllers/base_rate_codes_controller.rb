class BaseRateCodesController < ApplicationController
  # GET /base_rate_codes
  # GET /base_rate_codes.json
  def index
    @base_rate_codes = BaseRateCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @base_rate_codes }
    end
  end

  # GET /base_rate_codes/1
  # GET /base_rate_codes/1.json
  def show
    @base_rate_code = BaseRateCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @base_rate_code }
    end
  end

  # GET /base_rate_codes/new
  # GET /base_rate_codes/new.json
  def new
    @base_rate_code = BaseRateCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @base_rate_code }
    end
  end

  # GET /base_rate_codes/1/edit
  def edit
    @base_rate_code = BaseRateCode.find(params[:id])
  end

  # POST /base_rate_codes
  # POST /base_rate_codes.json
  def create
    @base_rate_code = BaseRateCode.new(params[:base_rate_code])

    respond_to do |format|
      if @base_rate_code.save
        format.html { redirect_to @base_rate_code, notice: 'Base rate code was successfully created.' }
        format.json { render json: @base_rate_code, status: :created, location: @base_rate_code }
      else
        format.html { render action: "new" }
        format.json { render json: @base_rate_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /base_rate_codes/1
  # PUT /base_rate_codes/1.json
  def update
    @base_rate_code = BaseRateCode.find(params[:id])

    respond_to do |format|
      if @base_rate_code.update_attributes(params[:base_rate_code])
        format.html { redirect_to @base_rate_code, notice: 'Base rate code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @base_rate_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /base_rate_codes/1
  # DELETE /base_rate_codes/1.json
  def destroy
    @base_rate_code = BaseRateCode.find(params[:id])
    @base_rate_code.destroy

    respond_to do |format|
      format.html { redirect_to base_rate_codes_url }
      format.json { head :no_content }
    end
  end
end
