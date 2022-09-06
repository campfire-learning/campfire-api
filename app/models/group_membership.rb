class GroupMembership < ApplicationRecord
  belongs_to :group
  belongs_to :user

  enum role: { admin: 1, memeber: 2 }
end
