class CourseEvent < ApplicationRecord
  belongs_to :course

  enum event_type: { lecture: 1, exam: 2, discussion: 3, presentation: 4, no_class: 5, other: 6 }
end
