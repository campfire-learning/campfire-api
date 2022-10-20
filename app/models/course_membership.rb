class CourseMembership < ApplicationRecord
  belongs_to :course
  belongs_to :user

  # this is the role from teaching/learning perspective
  enum role: { instructor: 'instructor', assistant: 'assistant', student: 'student' }

  before_create :set_order

  def set_order
    self.order = CourseMembership.where(user_id: user_id).count
  end
end
