# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User
  has_many :events, class_name: :CourseEvent
  has_many :course_memberships
  has_many :members, through: :course_memberships, source: :user

  enum term: { Spring: 1, Summer: 2, Fall: 3, Winter: 4 }
end
