class CreateCalendarEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :calendar_events do |t|
      t.string :title, null: false, default: 'Event'
      t.integer :owner_type, null: false
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.integer :duration
      t.datetime :start_time

      t.timestamps
    end
  end
end
