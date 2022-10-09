class Group < ApplicationRecord
  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User

  has_one :pinned_post, class_name: :Post
  has_many :group_memberships
  has_many :members, through: :group_membership, source: :user
  has_many :posts, as: :context

  def self.campfire_general
    Group.find(1)
  end

  after_create do |group|
    GroupMembership.create(
      group_id: group.id,
      user_id: group.creator_id,
      role: GroupMembership.roles[:admin]
    )
  end
end