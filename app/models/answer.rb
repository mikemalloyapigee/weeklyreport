class Answer < ActiveRecord::Base
  belongs_to :respondent
  belongs_to :reportdate
  def self.get_answer_by_respondent_and_report_ids(resp_id, repdate_id)
    where("respondent_id = ? and reportdate_id = ?", resp_id, repdate_id)
  end
end
