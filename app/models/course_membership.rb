class CourseMembership < ApplicationRecord
  belongs_to :course
  belongs_to :user

  # this is the role from teaching/learning perspective
  enum academic_role: { instructor: 1, teaching_assistant: 2, student: 3 }

  # this is the role from access control perspective
  enum user_role: { admin: 1, member: 2 }
end
