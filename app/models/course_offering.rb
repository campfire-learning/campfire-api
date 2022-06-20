class CourseOffering < ApplicationRecord
  belongs_to :course
  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User
end
