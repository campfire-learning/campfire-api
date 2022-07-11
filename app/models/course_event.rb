class CourseEvent < ApplicationRecord
  belongs_to :course

  enum event_type: %i[lecture exam discussion presentation no_class other]
end
