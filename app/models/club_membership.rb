class ClubMembership < ApplicationRecord
  belongs_to :club
  belongs_to :user

  enum role: { moderator: 'moderator', member: 'member' }

  before_create :set_order

  after_create do |club_membership|
    Channel.select(:id).where(context_type: "Club", context_id: club_membership.club_id).each do |channel|
      ChannelMembership.create(
        user_id: club_membership.user_id,
        channel_id: channel.id,
      )
    end
  end

  def set_order
    self.order = ClubMembership.where(user_id: user_id).count
  end
end
