class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.string :conversation_name
      t.string :conversation_type
      t.string :slug
      t.string :description
      t.string :status

      t.timestamps
    end
    add_index :conversations, :slug
  end
end
