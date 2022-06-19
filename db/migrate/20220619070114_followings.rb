class Followings < ActiveRecord::Migration[7.0]
  def change
    create_table :followings, id: false do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :followee, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
