class GroupMembership < ApplicationRecord
  belongs_to :group
  belongs_to :user

  enum role: { moderator: 'moderator', member: 'member' }

  before_create :set_order

  after_create do |group_membership|
    Channel.select(:id).where(context_type: "Group", context_id: group_membership.group_id).each do |channel| 
      ChannelMembership.create(
        user_id: group_membership.user_id,
        channel_id: channel.id,
      )
    end
  end

  def set_order
    self.order = GroupMembership.where(user_id: user_id).count
  end
end
