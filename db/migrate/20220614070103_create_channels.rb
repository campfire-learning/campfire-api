class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :channels do |t|
      t.references :context, polymorphic: true, null:false

      t.string :title, null:false
      t.integer :order, null:false
      t.text :description

      t.timestamps
      t.datetime :discarded_at
    end

    add_index :channels, [:context_type, :context_id, :title], unique: true
  end
end
