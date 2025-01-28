json.extract! product, :id, :name, :category_id, :producer_id, :price, :description, :created_at, :updated_at
json.url product_url(product, format: :json)
