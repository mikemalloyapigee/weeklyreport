module WeeklyreportHelper
  
  def set_start_and_end_dates(start_date, end_date)
    @start_date_fields = start_date.split("-")
    @start_date = Date.new(@start_date_fields[0].to_i, @start_date_fields[1].to_i, @start_date_fields[2].to_i)
    @start_date_str = "#{@months[@start_date.month]} #{@start_date.day.to_s}, #{@start_date.year.to_s}"
    @end_date_fields = end_date.split("-")
    @end_date = Date.new(@end_date_fields[0].to_i, @end_date_fields[1].to_i, @end_date_fields[2].to_i)
    @end_date_str = "#{@months[@end_date.month]} #{@end_date.day.to_s}, #{@end_date.year.to_s}"
    @begin_date = @start_date - 28
  end
  
  def get_responses(respondent_id, report_ids)
    responses = []
    report_ids.each do |id|
      ans = Answer.where("reportdate_id = ? and respondent_id = ?", id, respondent_id)
      if ans.first.nil?
        responses << 0
      else
        responses << ans.first.num_answers
      end
    end
    responses
  end
  
  def all_zeroes(responses)
    all_zeroes = true
    responses.each do |response|
      if response != 0
        all_zeroes = false
      end
    end
    all_zeroes
  end
  
  def create_respondent_entry(respondent, report_ids)
    responses = get_responses(respondent.id, report_ids)
    if all_zeroes(responses)
      respondent_entry = nil
    else
      respondent_entry = {:respondent => respondent}
      respondent_entry[:responses] = responses
    end
    respondent_entry
  end
  
  def create_respondent_tables
    reports = Reportdate.where("start_date >= ?", @begin_date).order("start_date desc")
    report_ids = []
    reports.each {|rep| report_ids << rep.id }
    responses = []
    Respondent.all.each do |respondent|
      respondent_entry = create_respondent_entry(respondent, report_ids)
      if !respondent_entry.nil?
        responses << respondent_entry
      end
    end
    employees = []
    non_employees = []
    responses.each do |response|
      if response[:respondent].employee == "Y"
        employees << response
      else
        non_employees << response
      end
    end
    sorted_employees = employees.sort_by{|emp| [emp[:respondent].department, emp[:respondent].full_name]}
    sorted_non_employees = non_employees.sort_by{|nemp| [nemp[:respondent].display_name]}
    respondent_tables = {:employees => sorted_employees, :non_employees => sorted_non_employees, :report_ids => report_ids}
  end
  
  def get_top_respondents(respondent_tables)
    employees = respondent_tables[:employees]
    sorted_employees = employees.sort_by{|employee| -employee[:responses][0]}
    i=0
    j=0
    curr_answers = sorted_employees[0][:responses][0]
    top_respondents = []
    while i<3 and curr_answers > 1
      top_respondents << sorted_employees[j]
      j = j+1
      answers = sorted_employees[j][:responses][0]
      if answers < curr_answers
        curr_answers = answers
        i = i+1
      end
    end
    top_respondents
  end
  
  def getTopQuestions
    end_date = Date.today
    questions = SOData(Date.new(2014, 01, 01), end_date)
    questions_by_views = questions.sort_by{|question| -question["view_count"]}
    i=0
    j=0
    top_views = []
    curr_views = questions_by_views[0]["view_count"]
    while i < 3
      top_views << questions_by_views[j]
      j = j + 1
      views = questions_by_views[j]["view_count"]
      if views < curr_views
        i = i+1
        curr_views = views
      end
    end
    questions_by_answers = questions.sort_by{|question| -question["answer_count"]}
    i=0
    j=0
    top_answers = []
    curr_answers = questions_by_answers[0]["answer_count"]
    while i<3 and curr_answers > 3
      top_answers << questions_by_answers[j]
      j = j + 1
      answers = questions_by_answers[j]["answer_count"]
      if answers < curr_answers
        i = i + 1
        curr_answers = answers
      end
    end
    top_questions = {:top_views => top_views, :top_answers => top_answers}
  end
  
  def make_percent_difference_string(curr_val, prev_val)
    percent_difference = ((curr_val.to_f - prev_val.to_f)/curr_val.to_f)*100
    diff_string = "%.2f" % [percent_difference] + "%"
    if percent_difference > 0
      diff_string = "+" + diff_string
    end
    diff_string
  end
  
  def calculate_percent_differences(curr_report, prev_report )
    views_str = make_percent_difference_string(curr_report.views, prev_report.views)
    ans_str = make_percent_difference_string(curr_report.num_answers, prev_report.num_answers)
    question_str = make_percent_difference_string(curr_report.questions, prev_report.questions)
    percent_differences = {:views => views_str, :answers => ans_str, :questions => question_str}
  end
end
