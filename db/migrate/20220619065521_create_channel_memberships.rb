class CreateChannelMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :channel_memberships, id: false do |t|
      t.references :channel, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role
      t.timestamps
    end
  end
end
