class CreateTabs < ActiveRecord::Migration[7.0]
  def change
    create_table :tabs do |t|
      t.string :context_type, null: false
      # there is not a foreign key constraint here -- be careful!
      t.integer :context_id, null: false

      t.string :name, null: false
      t.integer :order, null: false

      t.string :tab_context_type, null: false
      # there is not a foreign key constraint here -- be careful!
      t.integer :tab_context_id, null: false

      t.timestamps null: false
      t.datetime :discarded_at
    end

    add_index :club_memberships, [:context_type, :context_id, :name], unique: true
  end
end
