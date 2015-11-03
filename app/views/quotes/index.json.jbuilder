json.array!(@quotes) do |quote|
  json.extract! quote, :id, :title, :quote, :by
  json.url quote_url(quote, format: :json)
end
