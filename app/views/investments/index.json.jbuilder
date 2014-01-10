json.array!(@investments) do |investment|
  json.extract! investment, :id, :month, :amount, :total_inv
  json.url investment_url(investment, format: :json)
end
