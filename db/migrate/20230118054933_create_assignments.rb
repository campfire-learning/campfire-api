class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :rich_text
      t.string :assignment_type
      t.integer :grade_percent
      t.references :course, null: false, foreign_key: true
      t.string :submission_type  # online or offline
      t.timestamp :due_time

      t.timestamps
    end
  end
end
