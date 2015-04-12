json.array!(@journeys) do |journey|
  json.extract! journey, :id, :from, :to, :budget, :by, :people, :name
  json.url journey_url(journey, format: :json)
end
