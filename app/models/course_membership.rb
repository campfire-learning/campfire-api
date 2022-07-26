class CourseMembership < ApplicationRecord
  belongs_to :course
  belongs_to :user

  enum role: { instructor: 1, teaching_assistant: 2, student: 3 }
end
