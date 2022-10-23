class Club < ApplicationRecord
  include Discard::Model

  belongs_to :institution
  belongs_to :creator, class_name: :User, optional: true

  has_many :club_memberships
  has_many :members, -> { kept }, through: :club_memberships, source: :user

  has_many :channels, as: :context
  has_many :tabs, as: :context

  
  after_create do |club|
    ClubMembership.create(
      club_id: club.id,
      user_id: club.creator_id,
      role: ClubMembership.roles[:moderator]
    )

    Channel.create(
      context: club,
      title: 'general',
    )
  end

  def display_name
    discarded? ? "#{name} (inactive)" : name
  end
end
