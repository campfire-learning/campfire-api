class CreateSyllabuses < ActiveRecord::Migration[7.0]
  def change
    create_table :syllabuses do |t|
      t.text :rich_text
      t.references :course, null: false, foreign_key: true, index: false

      t.timestamps
    end

    add_index :syllabuses, [:course_id], unique: true
  end
end
