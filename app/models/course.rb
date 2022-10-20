# frozen_string_literal: true

class Course < ApplicationRecord
  include Discard::Model

  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User
  has_one :pinned_post, class_name: :Post
  has_many :events, class_name: :CourseEvent
  has_many :posts, as: :context
  has_many :course_memberships
  has_many :members, -> { kept }, through: :course_memberships, source: :user

  enum term: { spring: 'spring', summer: 'summer', fall: 'fall', winter: 'winter' }

  after_create do |course|
    CourseMembership.create(
      course_id: course.id,
      user_id: course.creator_id,
      role: CourseMembership.roles[:admin]
    )
  end

  def display_title
    discarded? ? "#{title} (inactive)" : title
  end
end
