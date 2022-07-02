class CourseOfferingEvent < ApplicationRecord
  belongs_to :course_offering
  belongs_to :course_event
end
