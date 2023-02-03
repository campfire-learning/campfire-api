class Grade < ApplicationRecord
  belongs_to :user
  belongs_to :assignment

  enum status: { completed: 'completed', late: 'late', missing: 'missing' }
end
