# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User
  has_many :events, class_name: :CourseEvent
  has_many :posts, as: :context
  has_many :course_memberships
  has_many :members, through: :course_memberships, source: :user
  belongs_to :time_zone, optional: true

  enum term: { spring: 1, summer: 2, fall: 3, winter: 4 }
end
