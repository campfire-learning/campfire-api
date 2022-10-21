class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.references :institution, null: false, foreign_key: true
      t.string :title, null: false

      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.boolean :public, null: false, default: true
      t.string :encrypted_password

      t.timestamps null: false
      t.datetime :discarded_at
    end

    add_index :groups, [:institution, :title], unique: true
  end
end
