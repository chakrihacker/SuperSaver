json.extract! category, :id, :name, :parent_id, :created_at, :updated_at
json.url category_url(category, format: :json)
if category.icon.attached?
  json.icon_url url_for(category.icon)
else
  json.icon_url nil
end