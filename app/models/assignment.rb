class Assignment < ApplicationRecord
  belongs_to :course
  has_many_attached :uploads

  enum assignment_type: { assignment: 'assignment', quiz: 'quiz', exam: 'exam' }
  enum submission_type: { online: 'online', offline: 'offline' }
end
