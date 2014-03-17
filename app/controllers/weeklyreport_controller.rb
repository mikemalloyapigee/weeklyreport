class WeeklyreportController < ApplicationController
  include WeeklyreportHelper
  
  def set_overalls
    @months = [nil, "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    @short_months = [nil, "Jan", "Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    @overalls = Overall.all.order("date desc").limit(6)
  end
  
  def index
    set_overalls
  end
  
  def create
    set_overalls
    if params[:sdate] != nil and params[:edate] != nil
      set_start_and_end_dates(params[:sdate], params[:edate])
      @respondent_tables = create_respondent_tables
      @top_questions = getTopQuestions
      @last_weeks_results = Reportdate.all.order("start_date desc").first
      @percent_differences = calculate_percent_differences(@last_weeks_results, Reportdate.all.order("start_date desc")[1] )
      @all_reports = Reportdate.all.order("start_date asc")
      @top_responders = get_top_respondents(@respondent_tables)
=begin
      last_weeks_end_date_fields = @last_weeks_results.end_date.split("-")
      last_weeks_end_date = Date.new(last_weeks_end_date_fields[0].to_i, last_weeks_end_date_fields[1].to_i,  last_weeks_end_date_fields[1].to_i)
      @last_weeks_end_date_title = "#{@short_months[last_weeks_end_date.month]} #{last_weeks_end_date.day.to_s},#{last_weeks_end_date.year.to_s}"
=end
    end
    render 'index'
  end
  
end
