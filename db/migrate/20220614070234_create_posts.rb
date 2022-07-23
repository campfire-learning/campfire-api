class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :creator_id, foreign_key: { to_table: :users }
      t.text :post_text
      t.integer :context_type
      t.integer :context_id
      t.boolean :pinned

      t.timestamps
    end
  end
end
