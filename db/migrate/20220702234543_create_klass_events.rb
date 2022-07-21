class CreateKlassEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :klass_events do |t|
      t.references :klass, null: false, foreign_key: true
      t.references :course_event, null: false, foreign_key: true
      t.timestamp :start_time
      t.integer :duration

      t.timestamps
    end
  end
end
