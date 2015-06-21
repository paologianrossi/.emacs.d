json.array!(@specimen) do |speciman|
  json.extract! speciman, :id
  json.url speciman_url(speciman, format: :json)
end
