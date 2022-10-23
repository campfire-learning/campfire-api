class Channel < ApplicationRecord
    include Discard::Model
  
    belongs_to :context, polymorphic: true

    has_many :posts
    has_many :channel_memberships

    before_create :set_order

    after_create do |channel|
      if channel.context_type == "Group" 
        users = GroupMembership.select(:user_id).where(group_id: channel.context_id)
      elsif channel.context_type == "Club"
        users = ClubMembership.select(:user_id).where(club_id: channel.context_id)
      elsif channel.context_type == "Course"
        users = CourseMembership.select(:user_id).where(course_id: channel.context_id)
      end
      users.each do |user|
        ChannelMembership.create(
          user_id: user.user_id,
          channel_id: channel.id,
        )
      end
    end

    def set_order
      self.order = Channel.where(context_type: context_type, context_id: context_id).count
    end
    
  end
  