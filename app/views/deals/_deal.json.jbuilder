json.extract! deal, :id, :deal_type, :name, :description, :vendor, :is_local_deal, :latitude, :longitude, :status, :end_date, :min_price, :cash_back, :selling_price, :user_id, :category_id, :created_at, :updated_at
json.url deal_url(deal, format: :json)
