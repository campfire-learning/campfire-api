class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :code  # such as "STATS 101"
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.integer :year
      t.integer :term
      t.integer :pinned_post_id
      t.date :start_date
      t.string :time_zone
      t.string :location
      t.text :description
      t.text :syllabus
      t.string :department
      t.datetime :discarded_at

      t.timestamps
      t.index %i[discarded_at]
    end
  end
end
