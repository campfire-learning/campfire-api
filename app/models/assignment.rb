class Assignment < ApplicationRecord
  belongs_to :course_offering

  enum assignment_type: { homework: 1, quiz: 2, exercise: 3, midterm: 4, final: 5 }
end