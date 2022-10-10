class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.integer :pinned_post_id
      t.text :description
      t.boolean :public
      t.datetime :discarded_at

      t.timestamps

      t.index %i[discarded_at]
    end
  end
end