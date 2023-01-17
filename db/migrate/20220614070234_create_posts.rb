class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true

      t.text :post_text, null: false
      t.references :reply_to_id, foreign_key: { to_table: :posts }

      t.datetime :discarded_at
      t.timestamps
    end

    add_index :posts, [:channel]
    add_index :posts, [:user]
    add_index :posts, [:discarded_at]
  end
end
