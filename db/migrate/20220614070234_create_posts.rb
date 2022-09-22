class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :author_id, foreign_key: { to_table: :users }
      t.text :post_text, null: false
      t.string :context_type, null: false
      t.integer :context_id, null: false

      t.timestamps

      t.index %i[context_type context_id], name: :index_posts_on_context, unique: true
    end
  end
end
