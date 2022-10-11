class CreateClubMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :club_memberships, id: false do |t|
      t.references :club, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role
      t.timestamps
    end
  end
end