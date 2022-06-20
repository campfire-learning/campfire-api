class CreateCourseOfferings < ActiveRecord::Migration[7.0]
  def change
    create_table :course_offerings do |t|
      t.references :course, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.date :start_date

      t.timestamps
    end
  end
end
