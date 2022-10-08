class Channel < ApplicationRecord
  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User

  has_one :pinned_post, class_name: :Post
  has_many :channel_memberships
  has_many :members, through: :channel_membership, source: :user
  has_many :posts, as: :context

  def self.campfire_general
    Channel.find(1)
  end

  after_create do |channel|
    ChannelMembership.create(
      channel_id: channel.id,
      user_id: channel.creator_id,
      role: ChannelMembership.roles[:admin]
    )
  end
end