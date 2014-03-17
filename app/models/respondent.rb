class Respondent < ActiveRecord::Base
  has_many :answers
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Respondent.create! row.to_hash
    end
  end
  
end
