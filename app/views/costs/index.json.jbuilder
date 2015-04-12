json.array!(@costs) do |cost|
  json.extract! cost, :id, :person, :description, :amount
  json.url cost_url(cost, format: :json)
end
