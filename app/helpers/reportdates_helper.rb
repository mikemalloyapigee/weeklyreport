module ReportdatesHelper
  
  def getSOData(start_date, end_date) 
    questions = SOData(start_date, end_date) 
    answers = 0
    views = 0
    question_ids = []
    questions.each do |question| 
      answers = answers + question["answer_count"]
      views = views + question["view_count"]
      question_ids << question["question_id"]
    end
    weekly_summary = {:questions => questions.length, :answers => answers, :views => views, :question_ids => question_ids}
  end
  
  def get_respondent(display_name)
    respondent = nil
    resp = Respondent.find_by_display_name(display_name)
    if resp.nil?
      respondent = Respondent.new()
      respondent.display_name = display_name
      respondent.employee = "N"
      respondent.save
    else
      respondent = resp
    end
    respondent.id
  end
  
  def process_answers(reportdate_id, question_ids)
    question_string = ""
    i=0
    while(i<question_ids.length)
      if i != 0
        question_string = question_string + "%3B"
      end
      question_string = question_string + question_ids[i].to_s
      i = i + 1
    end
    url = "https://api.stackexchange.com/2.2/questions/" + question_string + "/answers?order=desc&sort=activity&site=stackoverflow"
    jdata = curl_url(url)
    jdata["items"].each do |answer|
      display_name = answer["owner"]["display_name"]
      respondent_id = get_respondent(display_name)
      curr_answer = Answer.get_answer_by_respondent_and_report_ids(respondent_id, reportdate_id)
      if curr_answer.first.nil?
        new_answer = Answer.new()
        new_answer.respondent_id = respondent_id
        new_answer.reportdate_id = reportdate_id
        new_answer.num_answers = 1
        new_answer.save()
        new_answer.reload
      else
        new_answer = curr_answer.first
        new_answer.num_answers = new_answer.num_answers + 1
        new_answer.save()
      end
    end    
  end
  
end
