class CreateCourseOfferingsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :course_offerings_users do |t|
      t.references :course_offering, null: false
      t.references :user, null: false
      t.integer :role, null: false

      t.timestamps
    end
  end
end
