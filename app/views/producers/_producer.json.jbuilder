json.extract! producer, :id, :name, :email, :phone, :address, :created_at, :updated_at
json.url producer_url(producer, format: :json)
