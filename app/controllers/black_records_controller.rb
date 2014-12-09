class BlackRecordsController < ActionController::Base 
  # GET /black_records
  # GET /black_records.json
  def index
    @black_records = BlackRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @black_records }
    end
  end

  # GET /black_records/1
  # GET /black_records/1.json
  def show
    @black_record = BlackRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @black_record }
    end
  end

  # GET /black_records/new
  # GET /black_records/new.json
  def new
    @black_record = BlackRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @black_record }
    end
  end

  # GET /black_records/1/edit
  def edit
    @black_record = BlackRecord.find(params[:id])
  end

  # POST /black_records
  # POST /black_records.json
  def create
    @black_record = BlackRecord.new(params[:black_record])
    respond_to do |format|
      if @black_record.save
        format.html { redirect_to @black_record, notice: 'Black record was successfully created.' }
        format.json { render json: @black_record, status: :created, location: @black_record }
      else
        format.html { render action: "new" }
        format.json { render json: @black_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /black_records/1
  # PUT /black_records/1.json
  def update
    @black_record = BlackRecord.find(params[:id])

    respond_to do |format|
      if @black_record.update_attributes(params[:black_record])
        format.html { redirect_to @black_record, notice: 'Black record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @black_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /black_records/1
  # DELETE /black_records/1.json
  def destroy
    @black_record = BlackRecord.find_by_cid(params[:id])
    @black_record.destroy

    respond_to do |format|
      format.html { redirect_to black_records_url }
      format.json {render json: @black_record}
    end
  end
end
