class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :channels do |t|
      t.string :context_type, null: false
      # there is not a foreign key constraint here -- be careful!
      t.integer :context_id, null: false

      t.string :name, null: false
      t.integer :order, null: false

      t.timestamps null: false
      t.datetime :discarded_at
    end

    add_index :channels, [:context_type, :context_id, :name], unique: true
  end
end
