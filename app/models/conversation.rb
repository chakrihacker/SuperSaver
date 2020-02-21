# frozen_string_literal: true

class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :conversation_memberships, dependent: :destroy
  has_many :users, through: :conversation_memberships

  def self.create_with_users(users, slug)
    conversation = Conversation.find_by(slug: slug)
    if conversation
      #  do something
    else
      conversation = create(
        conversation_type: 'active',
        conversation_name: 'New Conversation',
        slug: slug,
        status: 'active'
      )
      conversation.add_users(users)
    end
    conversation
  end

  def add_users(users)
    Array(users).each do |user|
      ConversationMembership.create!(user_id: user.id, conversation_id: id)
    end
  end
end
