class CourseMembership < ApplicationRecord
  belongs_to :course
  belongs_to :user

  enum role: { instructor: 'instructor', assistant: 'assistant', student: 'student', moderator: 'moderator' }

  before_create :set_order

  def set_order
    self.order = CourseMembership.where(user_id: user_id).count
  end
end
