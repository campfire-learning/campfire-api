class Course < ApplicationRecord
  include Discard::Model

  belongs_to :institution
  belongs_to :creator, class_name: :User, optional: true

  has_many :course_memberships
  has_many :members, -> { kept }, through: :course_memberships, source: :user

  has_one :syllabus
  has_many :assignments
  has_many :channels, -> { order order: :desc }, as: :context
  has_many :tabs, as: :context

  enum term: { spring: 'spring', summer: 'summer', fall: 'fall', winter: 'winter' }

  after_create do |course|
    user = User.select(:user_type).where(id: course.creator_id).first
    role = if user.user_type == "instructor"
             CourseMembership.roles[:instructor]
           else
             CourseMembership.roles[:moderator]
           end

    CourseMembership.create(
      course_id: course.id,
      user_id: course.creator_id,
      role:
    )

    Channel.create(
      context: course,
      title: 'general'
    )
  end

  def display_title
    discarded? ? "#{title} (inactive)" : title
  end
end
