class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades do |t|
      t.references :user, null: false, foreign_key: true
      t.references :assignment, null: false, foreign_key: true
      t.integer :score
      t.string :status, null: false

      t.timestamps
    end

    add_index :grades, [:user_id, :assignment_id], unique: true
  end
end
