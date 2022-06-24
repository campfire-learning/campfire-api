class CourseOfferingUser < ApplicationRecord
  belongs_to :course_offering
  belongs_to :user

  enum role: %i[instructor teaching_assistant student]
end
