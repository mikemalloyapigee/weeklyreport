class Overall < ActiveRecord::Base
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Overall.create! row.to_hash
    end
  end
  
end
