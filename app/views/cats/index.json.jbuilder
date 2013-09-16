json.array!(@cats) do |cat|
  json.extract! cat, :name, :description, :image_url, :price
  json.url cat_url(cat, format: :json)
end
