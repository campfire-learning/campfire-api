class CreateReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      
      t.string :reaction, null: false

      t.timestamps null: false
    end

    add_index :reactions, [:user_id, :post_id, :reaction], unique: true
  end
end
