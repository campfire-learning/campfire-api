class ChannelMembership < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  enum role: { admin: 1, memeber: 2 }
end
