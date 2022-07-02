class CreateCourseOfferingEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :course_offering_events do |t|
      t.references :course_offering, null: false, foreign_key: true
      t.references :course_event, null: false, foreign_key: true
      t.timestamp :start_time
      t.integer :duration

      t.timestamps
    end
  end
end
