json.array!(@slings) do |sling|
  json.extract! sling, :id, :brand_id, :name, :weight, :colors, :blend, :release_date, :link, :status
  json.url sling_url(sling, format: :json)
end
