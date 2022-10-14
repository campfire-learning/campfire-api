class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.text :post_text, null: false
      t.string :context_type, null: false
      t.integer :context_id, null: false
      t.datetime :discarded_at

      t.timestamps

      t.index %i[context_type context_id], name: :index_posts_on_context
      t.index %i[discarded_at]
    end
  end
end
