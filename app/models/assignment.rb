class Assignment < ApplicationRecord
  belongs_to :course_offering

  enum assignment_type: %i[homework quiz exercise midterm final]
end
