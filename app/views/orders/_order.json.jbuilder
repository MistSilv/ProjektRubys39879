json.extract! order, :id, :client_id, :total, :status, :placed_at, :created_at, :updated_at
json.url order_url(order, format: :json)
