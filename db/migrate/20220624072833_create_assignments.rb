class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.references :course_offering, null: false, foreign_key: true
      t.text :description
      t.integer :assignment_type
      t.float :percent

      t.timestamps
    end
  end
end
