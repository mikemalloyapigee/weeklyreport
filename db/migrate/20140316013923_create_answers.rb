class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :num_answers
      t.integer :reportdate_id
      t.integer :respondent_id

      t.timestamps
    end
  end
end
