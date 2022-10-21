class CreateClubMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :club_memberships do |t|
      t.references :club, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.integer :order, null: false
      t.string :role, null: false
      t.boolean :banned, null: false, default: false

      t.timestamps null: false
    end

    add_index :club_memberships, [:user, :club], unique: true
  end
end
