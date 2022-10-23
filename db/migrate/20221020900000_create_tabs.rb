class CreateTabs < ActiveRecord::Migration[7.0]
  def change
    create_table :tabs do |t|
      t.references :context, polymorphic: true, null: false

      t.string :name, null: false
      t.integer :order, null: false

      t.string :tab_entity_type, null: false
      t.integer :tab_entity_id, null: false

      t.timestamps null: false
      t.datetime :discarded_at
    end

    add_index :club_memberships, [:context_type, :context_id, :name], unique: true
  end
end