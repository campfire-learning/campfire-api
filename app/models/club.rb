class Club < ApplicationRecord
  include Discard::Model

  belongs_to :institution
  belongs_to :creator, class_name: :User

  has_many :club_memberships
  has_many :members, -> { kept }, through: :club_memberships, source: :user

  has_many :channels, as: :context

  after_create do |club|
    ClubMembership.create(
      club_id: club.id,
      user_id: club.creator_id,
      role: ClubMembership.roles[:moderator]
    )
  end

  def display_name
    discarded? ? "#{name} (inactive)" : name
  end
end
