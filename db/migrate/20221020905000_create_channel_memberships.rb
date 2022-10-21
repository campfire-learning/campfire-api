class CreateChannelMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :channel_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true

      t.integer :mention_count, null: false, default: 0
      t.integer :new_message_count, null: false, default: 0

      t.datetime :last_visited
      t.timestamps null: false
    end

    add_index :channel_memberships, [:user, :channel], unique: true
  end
end
