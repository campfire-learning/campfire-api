class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :likable_id, null: false
      t.string :likable_type, null: false

      t.index [:user_id, :likable_type, :likable_id], unique: true
      t.index [:likable_type, :likable_id]

      t.timestamps
    end
  end
end
