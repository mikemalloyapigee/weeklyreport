class CreateRespondents < ActiveRecord::Migration
  def change
    create_table :respondents do |t|
      t.string :name
      t.string :display_name
      t.string :employee
      t.string :full_name
      t.string :department

      t.timestamps
    end
  end
end
