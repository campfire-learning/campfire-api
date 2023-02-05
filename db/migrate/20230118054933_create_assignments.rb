class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :rich_text
      t.string :assignment_type  # homework, quiz, exam, etc.
      t.references :course, null: false, foreign_key: true
      t.string :submission_type  # online or offline
      t.string :grade_type, null: false  # numeric, passing, letter
      t.float :course_percent
      t.timestamp :due_time

      t.timestamps
    end
  end
end
