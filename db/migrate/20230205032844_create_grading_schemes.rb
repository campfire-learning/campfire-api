
class CreateGradingSchemes < ActiveRecord::Migration[7.0]
  def change
    create_table :grading_schemes do |t|
      t.string :name  # ex: "Standard GPA Grades", "Simplified GPA Grades"

      t.timestamps
    end

    add_index :grading_schemes, [:name]
  end
end
