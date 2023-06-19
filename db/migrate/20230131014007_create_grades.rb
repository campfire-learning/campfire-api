class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gradable, polymorphic: true, null: false
      t.float :score  # percent
      t.references :grading_level  # GPA level
      t.string :status, null: false

      t.timestamps
    end

    add_index :grades, [:user_id, :gradable_type, :gradable_id], unique: true
  end
end
