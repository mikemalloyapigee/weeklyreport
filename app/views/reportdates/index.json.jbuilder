json.array!(@reportdates) do |reportdate|
  json.extract! reportdate, :id, :start_date, :end_date
  json.url reportdate_url(reportdate, format: :json)
end
