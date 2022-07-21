class Group < ApplicationRecord
  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User

  has_many :users, through: :group_membership
end
