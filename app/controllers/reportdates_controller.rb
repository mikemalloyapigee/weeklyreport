class ReportdatesController < ApplicationController
  include ReportdatesHelper
  before_action :set_reportdate, only: [:show, :edit, :update, :destroy]

  # GET /reportdates
  # GET /reportdates.json
  def index
    @reportdates = Reportdate.all
  end

  # GET /reportdates/1
  # GET /reportdates/1.json
  def show
  end

  # GET /reportdates/new
  def new
    @reportdate = Reportdate.new
  end

  # GET /reportdates/1/edit
  def edit
  end

  # POST /reportdates
  # POST /reportdates.json
  def create
    @reportdate = Reportdate.new(reportdate_params)
    weekly_summary = getSOData(@reportdate.start_date, @reportdate.end_date)
    @reportdate.questions = weekly_summary[:questions]
    @reportdate.num_answers = weekly_summary[:answers]
    @reportdate.views = weekly_summary[:views]

    respond_to do |format|
      if @reportdate.save
        process_answers(@reportdate.id, weekly_summary[:question_ids])
        format.html { redirect_to @reportdate, notice: 'Reportdate was successfully created.' }
        format.json { render action: 'show', status: :created, location: @reportdate }
      else
        format.html { render action: 'new' }
        format.json { render json: @reportdate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reportdates/1
  # PATCH/PUT /reportdates/1.json
  def update
    respond_to do |format|
      if @reportdate.update(reportdate_params)
        format.html { redirect_to @reportdate, notice: 'Reportdate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reportdate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reportdates/1
  # DELETE /reportdates/1.json
  def destroy
    @reportdate.destroy
    respond_to do |format|
      format.html { redirect_to reportdates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reportdate
      @reportdate = Reportdate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reportdate_params
      params.require(:reportdate).permit(:start_date, :end_date)
    end
end
