class ClubMembership < ApplicationRecord
  belongs_to :club
  belongs_to :user

  enum role: { moderator: 'moderator', member: 'member' }

  before_create :set_order

  def set_order
    self.order = ClubMembership.where(:user_id => user_id).count
  end
end
