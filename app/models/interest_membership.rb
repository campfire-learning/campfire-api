class InterestMembership < ApplicationRecord
  belongs_to :interest
  belongs_to :user

  enum role: { moderator: 'moderator', member: 'member' }

  before_create :set_order

  after_create do |interest_membership|
    Channel.select(:id).where(context_type: "Interest", context_id: interest_membership.interest_id).each do |channel| 
      ChannelMembership.create(
        user_id: interest_membership.user_id,
        channel_id: channel.id,
      )
    end
  end

  def set_order
    self.order = InterestMembership.where(user_id: user_id).count
  end
end
