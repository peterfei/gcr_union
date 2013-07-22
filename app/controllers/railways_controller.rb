class RailwaysController < ApplicationController
  # GET /railways
  # GET /railways.json
  def index
    @railways = Railway.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @railways }
    end
  end

  # GET /railways/1
  # GET /railways/1.json
  def show
    @railway = Railway.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @railway }
    end
  end

  # GET /railways/new
  # GET /railways/new.json
  def new
    @railway = Railway.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @railway }
    end
  end

  # GET /railways/1/edit
  def edit
    @railway = Railway.find(params[:id])
  end

  # POST /railways
  # POST /railways.json
  def create
    @railway = Railway.new(params[:railway])

    respond_to do |format|
      if @railway.save
        format.html { redirect_to @railway, notice: 'Railway was successfully created.' }
        format.json { render json: @railway, status: :created, location: @railway }
      else
        format.html { render action: "new" }
        format.json { render json: @railway.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /railways/1
  # PUT /railways/1.json
  def update
    @railway = Railway.find(params[:id])

    respond_to do |format|
      if @railway.update_attributes(params[:railway])
        format.html { redirect_to @railway, notice: 'Railway was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @railway.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /railways/1
  # DELETE /railways/1.json
  def destroy
    @railway = Railway.find(params[:id])
    @railway.destroy

    respond_to do |format|
      format.html { redirect_to railways_url }
      format.json { head :no_content }
    end
  end
end
