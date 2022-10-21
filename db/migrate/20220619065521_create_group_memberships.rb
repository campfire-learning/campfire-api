class CreateGroupMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :group_memberships do |t|
      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.integer :order, null: false
      t.string :role, null: false
      t.boolean :banned, null: false, default: false

      t.timestamps null: false
    end

    add_index :group_memberships, [:user, :group], unique: true
  end
end
