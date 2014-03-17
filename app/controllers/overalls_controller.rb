class OverallsController < ApplicationController
  before_action :set_overall, only: [:show, :edit, :update, :destroy]

  # GET /overalls
  # GET /overalls.json
  def index
    @overalls = Overall.all.order("date desc")
    @months = [nil, "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
  end
  
  def import
    Overall.import(params[:file])
    redirect_to 'index', notice: "Products imported."
  end

  # GET /overalls/1
  # GET /overalls/1.json
  def show
  end

  # GET /overalls/new
  def new
    @overall = Overall.new
  end

  # GET /overalls/1/edit
  def edit
  end

  # POST /overalls
  # POST /overalls.json
  def create
    @overall = Overall.new(overall_params)

    respond_to do |format|
      if @overall.save
        format.html { redirect_to @overall, notice: 'Overall was successfully created.' }
        format.json { render action: 'show', status: :created, location: @overall }
      else
        format.html { render action: 'new' }
        format.json { render json: @overall.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /overalls/1
  # PATCH/PUT /overalls/1.json
  def update
    respond_to do |format|
      if @overall.update(overall_params)
        format.html { redirect_to @overall, notice: 'Overall was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @overall.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /overalls/1
  # DELETE /overalls/1.json
  def destroy
    @overall.destroy
    respond_to do |format|
      format.html { redirect_to overalls_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_overall
      @overall = Overall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def overall_params
      params.require(:overall).permit(:date, :desk, :getsat, :usergrid, :feedback, :appcraft, :stackoverflow, :help)
    end
end
