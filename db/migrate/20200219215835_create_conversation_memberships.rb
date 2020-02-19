class CreateConversationMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :conversation_memberships do |t|
      t.references :conversation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :conversation_memberships, [:user_id, :conversation_id]
  end
end
