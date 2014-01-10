json.array!(@users) do |user|
  json.extract! user, :id, :name, :salary, :total_amount
  json.url user_url(user, format: :json)
end
