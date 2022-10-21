class GroupMembership < ApplicationRecord
  belongs_to :group
  belongs_to :user

  enum role: { moderator: 'moderator', member: 'member' }

  before_create :set_order

  def set_order
    self.order = GroupMembership.where(user_id: user_id).count
  end
end
