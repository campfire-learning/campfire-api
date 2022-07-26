class CreateCourseEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :course_events do |t|
      t.integer :course_id, null: false
      t.string :title, null: false
      t.string :description
      t.integer :event_type, null: false
      t.datetime :event_time, null: false

      t.timestamps
    end
  end
end
