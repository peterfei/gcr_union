class ShunfengchesController < ApplicationController
  # GET /shunfengches
  # GET /shunfengches.json
  def index
    @shunfengches = Shunfengche.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shunfengches }
    end
  end

  # GET /shunfengches/1
  # GET /shunfengches/1.json
  def show
    @shunfengch = Shunfengche.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shunfengch }
    end
  end

  # GET /shunfengches/new
  # GET /shunfengches/new.json
  def new
    @shunfengch = Shunfengche.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shunfengch }
    end
  end

  # GET /shunfengches/1/edit
  def edit
    @shunfengch = Shunfengche.find(params[:id])
  end

  # POST /shunfengches
  # POST /shunfengches.json
  def create
    @shunfengch = Shunfengche.new(params[:shunfengch])

    respond_to do |format|
      if @shunfengch.save
        format.html { redirect_to @shunfengch, notice: 'Shunfengche was successfully created.' }
        format.json { render json: @shunfengch, status: :created, location: @shunfengch }
      else
        format.html { render action: "new" }
        format.json { render json: @shunfengch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shunfengches/1
  # PUT /shunfengches/1.json
  def update
    @shunfengch = Shunfengche.find(params[:id])

    respond_to do |format|
      if @shunfengch.update_attributes(params[:shunfengch])
        format.html { redirect_to @shunfengch, notice: 'Shunfengche was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shunfengch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shunfengches/1
  # DELETE /shunfengches/1.json
  def destroy
    @shunfengch = Shunfengche.find(params[:id])
    @shunfengch.destroy

    respond_to do |format|
      format.html { redirect_to shunfengches_url }
      format.json { head :no_content }
    end
  end
end
