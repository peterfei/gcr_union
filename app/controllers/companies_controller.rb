# coding: utf-8
class CompaniesController < ApplicationController
  before_filter  :need_sign_in
  # GET /companies
  # GET /companies.json
  def index
    if current_user.role=='oprator'
      @where = "#{current_user.company_id}"
      @search = Company.where(:id=>@where).search(params[:search])
    else
      @search = Company.search(params[:search])
    end
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
    @result = 0
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
    if params[:company].present?
      params[:company][:status] = 0
      params[:company][:created_at] = Time.now
      #params[:company][:manager_user_id] = current_user.id
    end
    
    @company = Company.new(params[:company])
    @result = 0
    respond_to do |format|
      if @company.save 
        @search = Company.search(params[:search])
        @companies=@search.page params[:page]
        @result = 1
        format.js {render 'index'}
        format.json { render json: @company, status: :created, location: @company }
      else
        format.js { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])
    @result = 0
    respond_to do |format|
      if params[:company].present?
        params[:company][:updated_at] = Time.now
      end
      if @company.update_attributes(params[:company]) 
        @search = Company.search(params[:search])
        @companies=@search.page params[:page]
        @result = 1
        #format.html { redirect_to @company, notice: '公司信息更新成功.' }
        format.js {render "index"}
        format.json { head :no_content }
      else
        format.html { redirect_to edit_company_path(params[:id]) }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    
    respond_to do |format|
      #format.html { redirect_to companies_url } 
      if @company.destroy 
        format.js
        format.json { head :no_content } 
      else  
        @errors = "该公司下有门店，不能删除!"
        flash[:error] = @errors 
        #format.html {redirect_to :index}
        format.js
      end
      
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
