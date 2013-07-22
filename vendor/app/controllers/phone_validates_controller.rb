class PhoneValidatesController < ApplicationController
  # GET /phone_validates
  # GET /phone_validates.json
  def index
    @phone_validates = PhoneValidate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @phone_validates }
    end
  end

  # GET /phone_validates/1
  # GET /phone_validates/1.json
  def show
    @phone_validate = PhoneValidate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @phone_validate }
    end
  end

  # GET /phone_validates/new
  # GET /phone_validates/new.json
  def new
    @phone_validate = PhoneValidate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @phone_validate }
    end
  end

  # GET /phone_validates/1/edit
  def edit
    @phone_validate = PhoneValidate.find(params[:id])
  end

  # POST /phone_validates
  # POST /phone_validates.json
  def create
    @phone_validate = PhoneValidate.new(params[:phone_validate])

    respond_to do |format|
      if @phone_validate.save
        format.html { redirect_to @phone_validate, notice: 'Phone validate was successfully created.' }
        format.json { render json: @phone_validate, status: :created, location: @phone_validate }
      else
        format.html { render action: "new" }
        format.json { render json: @phone_validate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /phone_validates/1
  # PUT /phone_validates/1.json
  def update
    @phone_validate = PhoneValidate.find(params[:id])

    respond_to do |format|
      if @phone_validate.update_attributes(params[:phone_validate])
        format.html { redirect_to @phone_validate, notice: 'Phone validate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @phone_validate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_validates/1
  # DELETE /phone_validates/1.json
  def destroy
    @phone_validate = PhoneValidate.find(params[:id])
    @phone_validate.destroy

    respond_to do |format|
      format.html { redirect_to phone_validates_url }
      format.json { head :no_content }
    end
  end
end
