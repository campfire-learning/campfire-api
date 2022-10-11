class CreateCourseMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :course_memberships do |t|
      t.references :course, null: false
      t.references :user, null: false
      t.integer :order, require: true
      t.integer :academic_role
      t.integer :user_role

      t.timestamps
    end
  end
end
