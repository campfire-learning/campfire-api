class Course < ApplicationRecord
  include Discard::Model

  belongs_to :institution
  belongs_to :creator, class_name: :User

  has_many :course_memberships
  has_many :members, -> { kept }, through: :course_memberships, source: :user

  has_many :channels, as: :context

  enum term: { spring: 'spring', summer: 'summer', fall: 'fall', winter: 'winter' }

  # TODO: should be based on user_role if instructor -> instructor, if student -> moderator
  after_create do |course|
    logger.info course.id
    logger.info course.creator_id 
    CourseMembership.create(
      course_id: course.id,
      user_id: course.creator_id,
      role: CourseMembership.roles[:instructor]
    )
  end

  def display_title
    discarded? ? "#{title} (inactive)" : title
  end
end
