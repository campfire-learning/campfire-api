class ClubMembership < ApplicationRecord
  belongs_to :club
  belongs_to :user

  enum role: { admin: 1, memeber: 2 }
end
