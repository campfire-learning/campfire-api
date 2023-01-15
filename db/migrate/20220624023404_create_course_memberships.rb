class CreateCourseMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :course_memberships do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.integer :order, null: false
      t.string :role, null: false
      t.boolean :banned, null: false, default: false

      t.timestamps null: false
    end

    add_index :course_memberships, [:user_id, :course_id], unique: true
  end
end
