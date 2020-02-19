json.extract! conversation, :id, :conversation_name, :conversation_type, :slug, :description, :status, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
