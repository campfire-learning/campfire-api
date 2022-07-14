class CourseOfferingUser < ApplicationRecord
  belongs_to :course_offering
  belongs_to :user

  enum role: { instructor: 1, teaching_assistant: 2, student: 3 }
end
