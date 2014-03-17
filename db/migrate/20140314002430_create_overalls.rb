class CreateOveralls < ActiveRecord::Migration
  def change
    create_table :overalls do |t|
      t.date :date
      t.integer :desk
      t.integer :getsat
      t.integer :usergrid
      t.integer :feedback
      t.integer :appcraft
      t.integer :stackoverflow
      t.integer :help

      t.timestamps
    end
  end
end
