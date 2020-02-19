class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :conversation_memberships, dependent: :destroy
  has_many :users, through: :conversation_memberships
end
