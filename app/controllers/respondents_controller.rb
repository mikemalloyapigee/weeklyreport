class RespondentsController < ApplicationController
  before_action :set_respondent, only: [:show, :edit, :update, :destroy]

  # GET /respondents
  # GET /respondents.json
  def index
    @respondents = Respondent.all.order("employee desc, display_name asc")
  end
  
  def import
    Respondent.import(params[:file])
    redirect_to 'index', notice: "Products imported."
  end

  # GET /respondents/1
  # GET /respondents/1.json
  def show
  end

  # GET /respondents/new
  def new
    @respondent = Respondent.new
  end

  # GET /respondents/1/edit
  def edit
  end

  # POST /respondents
  # POST /respondents.json
  def create
    @respondent = Respondent.new(respondent_params)

    respond_to do |format|
      if @respondent.save
        format.html { redirect_to @respondent, notice: 'Respondent was successfully created.' }
        format.json { render action: 'show', status: :created, location: @respondent }
      else
        format.html { render action: 'new' }
        format.json { render json: @respondent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /respondents/1
  # PATCH/PUT /respondents/1.json
  def update
    respond_to do |format|
      if @respondent.update(respondent_params)
        format.html { redirect_to @respondent, notice: 'Respondent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @respondent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /respondents/1
  # DELETE /respondents/1.json
  def destroy
    @respondent.destroy
    respond_to do |format|
      format.html { redirect_to respondents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_respondent
      @respondent = Respondent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def respondent_params
      params.require(:respondent).permit(:name, :display_name, :employee, :full_name, :department)
    end
end
