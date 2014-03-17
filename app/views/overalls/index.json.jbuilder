json.array!(@overalls) do |overall|
  json.extract! overall, :id, :date, :desk, :getsat, :usergrid, :feedback, :appcraft, :stackoverflow, :help
  json.url overall_url(overall, format: :json)
end
