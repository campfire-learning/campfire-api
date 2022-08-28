class Group < ApplicationRecord
  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User

  has_one :pinned_post, class_name: :Post
  has_many :group_membership
  has_many :members, through: :group_membership, source: :user
  has_many :posts, as: :context
end
