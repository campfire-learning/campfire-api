class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :comment_text, null: false, foreign_key: { to_table: :users }
      t.integer :author_id, null: false
      t.string :context_type, null: false
      t.integer :context_id, null: false

      t.timestamps
    end
  end
end
