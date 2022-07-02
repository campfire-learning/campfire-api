class CreateCourseEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :course_events do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
