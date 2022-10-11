# frozen_string_literal: true

class Course < ApplicationRecord
  include Discard::Model

  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User
  belongs_to :time_zone, optional: true

  has_one :pinned_post, class_name: :Post
  has_many :events, class_name: :CourseEvent
  has_many :posts, as: :context
  has_many :course_memberships
  has_many :members, through: :course_memberships, source: :user

  enum term: { spring: 1, summer: 2, fall: 3, winter: 4 }

  after_create do |course|
    CourseMembership.create(
      course_id: course.id,
      user_id: course.creator_id,
      user_role: CourseMembership.user_roles[:admin],
      order: CourseMembership.where(:user_id => course.creator_id).count
    )
  end

  def display_title
    discarded? ? "#{title} (inactive)" : title
  end
end
