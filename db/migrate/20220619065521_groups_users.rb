class GroupsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :groups_users, id: false do |t|
      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
