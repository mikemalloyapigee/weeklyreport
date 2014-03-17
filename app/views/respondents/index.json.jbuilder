json.array!(@respondents) do |respondent|
  json.extract! respondent, :id, :name, :display_name, :employee, :full_name, :department
  json.url respondent_url(respondent, format: :json)
end
