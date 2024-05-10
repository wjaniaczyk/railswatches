json.extract! watch, :id, :name, :description, :category, :price, :photo_url, :created_at, :updated_at
json.url watch_url(watch, format: :json)
