class Club < ApplicationRecord
  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User

  has_one :pinned_post, class_name: :Post
  has_many :club_memberships
  has_many :members, through: :club_membership, source: :user
  has_many :posts, as: :context

  after_create do |group|
    ClubMembership.create(
      group_id: group.id,
      user_id: group.creator_id,
      role: ClubMembership.roles[:admin]
    )
end
