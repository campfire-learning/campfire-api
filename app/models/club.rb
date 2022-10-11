class Club < ApplicationRecord
  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User

  has_one :pinned_post, class_name: :Post
  has_many :club_memberships
  has_many :members, through: :club_memberships, source: :user
  has_many :posts, as: :context

  after_create do |club|
    ClubMembership.create(
      club_id: club.id,
      user_id: club.creator_id,
      role: ClubMembership.roles[:admin],
      order: ClubMembership.where(:user_id => club.creator_id).count
    )
  end 
end
