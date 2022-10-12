class ClubMembership < ApplicationRecord
  belongs_to :club
  belongs_to :user

  enum role: { admin: 1, memeber: 2 }

  before_create :set_order

  def set_order
    self.order = ClubMembership.where(:user_id => user_id).count
  end
end
