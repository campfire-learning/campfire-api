
class CreateGradingLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :grading_levels do |t|
      t.references :grading_scheme
      t.string :level_letter
      t.string :definition
      t.float :max_percent
      t.float :min_percent
      t.float :points

      t.timestamps
    end

    add_index :grading_levels, [:grading_scheme_id, :level_letter], unique: true
  end
end
