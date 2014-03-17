class AddAnswerNumToReportdate < ActiveRecord::Migration
  def change
    add_column :reportdates, :num_answers, :integer
    remove_column :reportdates, :answers
  end
end
