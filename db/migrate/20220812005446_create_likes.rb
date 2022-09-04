class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :likable_id, null: false
      t.string :likable_type, null: false

      t.index %i[likable_type likable_id user_id], unique: true
      t.timestamps
    end
  end
end
