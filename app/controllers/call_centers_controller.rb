class CallCentersController < ApplicationController
  # GET /call_centers
  # GET /call_centers.json
  def index
    @call_centers = CallCenter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @call_centers }
    end
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
    @call_center = CallCenter.new(params[:call_center])

    respond_to do |format|
      if @call_center.save
        format.html { redirect_to @call_center, notice: 'Call center was successfully created.' }
        format.json { render json: @call_center, status: :created, location: @call_center }
      else
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
end
