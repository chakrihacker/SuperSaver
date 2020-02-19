json.extract! conversation_membership, :id, :conversation_id, :user_id, :created_at, :updated_at
json.url conversation_membership_url(conversation_membership, format: :json)
