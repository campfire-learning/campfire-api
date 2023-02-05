class Grade < ApplicationRecord
  belongs_to :user
  belongs_to :gradable, polymorphic: true  # assignment or course

  enum status: { completed: 'completed', late: 'late', missing: 'missing' }
end
