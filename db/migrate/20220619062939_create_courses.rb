class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.integer :year, null: false
      t.integer :term
      t.integer :pinned_post_id
      t.date :start_date
      t.references :time_zone
      t.string :location
      t.text :description
      t.text :syllabus
      t.datetime :discarded_at

      t.timestamps
      t.index %i[discarded_at]
    end
  end
end
