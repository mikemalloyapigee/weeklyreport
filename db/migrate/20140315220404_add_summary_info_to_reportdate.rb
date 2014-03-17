class AddSummaryInfoToReportdate < ActiveRecord::Migration
  def change
    add_column :reportdates, :questions, :integer
    add_column :reportdates, :answers, :integer
    add_column :reportdates, :views, :integer
  end
end
