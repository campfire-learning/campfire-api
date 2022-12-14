class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.references :institution, null: false, foreign_key: true
      t.string :title, null: false
      t.string :icon

      t.string :code  # ex: "STATS 101"
      t.string :department

      t.references :creator, foreign_key: { to_table: :users }

      t.boolean :public, null: false, default: true
      t.string :encrypted_password

      t.integer :year
      t.string :term

      t.timestamps null: false
      t.datetime :discarded_at
    end

    add_index :courses, [:institution_id, :code, :year, :term], unique: true
    add_index :courses, [:institution_id, :title, :year, :term], unique: true
  end
end
