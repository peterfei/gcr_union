# coding: utf-8
class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.json
  def index
    #@companies = Company.all
    #
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @companies }
    #end


    @search = Company.search(params[:search])
    @companies=@search.page params[:page]

    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render_select2 @companies, text:'company_name'}
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new

    respond_to do |format|
      format.js
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: '公司信息新增成功' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: '公司信息更新成功.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      #format.html { redirect_to companies_url }
      format.js
      format.json { head :no_content }
    end
  end

  def alter_status
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.status==0
        @company.update_attribute(:status, 1)
      else
        @company.update_attribute(:status, 0)
      end
      #format.html { redirect_to drivers_url }
      format.js
      format.json { head :no_content }
    end
  end
end
