class Group < ApplicationRecord
  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User

  has_many :group_membership
  has_many :members, through: :group_membership, source: :user
end
