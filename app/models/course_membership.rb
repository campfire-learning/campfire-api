class CourseMembership < ApplicationRecord
  belongs_to :course
  belongs_to :user

  enum role: { instructor: 'instructor', assistant: 'assistant', student: 'student', moderator: 'moderator' }

  before_create :set_order

  after_create do |course_membership|
    Channel.select(:id).where(context_type: "Course", context_id: course_membership.course_id).each do |channel|
      ChannelMembership.create(
        user_id: course_membership.user_id,
        channel_id: channel.id,
      )
    end
  end

  def set_order
    self.order = CourseMembership.where(user_id: user_id).count
  end
end
