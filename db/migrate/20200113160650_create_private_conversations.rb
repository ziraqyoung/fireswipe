class CreatePrivateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :private_conversations do |t|
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
    add_index :private_conversations, :sender_id
    add_index :private_conversations, :recipient_id
    add_index :private_conversations, [:sender_id, :recipient_id], unique: true
  end
end
