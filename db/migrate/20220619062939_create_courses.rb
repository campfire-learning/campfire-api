class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :time_zone
      t.integer :year, null: false
      t.integer :term
      t.date :start_date, null: false
      t.text :description
      t.text :location

      t.timestamps
    end
  end
end
