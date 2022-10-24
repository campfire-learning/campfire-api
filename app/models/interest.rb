class Interest < ApplicationRecord
  include Discard::Model

  belongs_to :institution
  belongs_to :creator, class_name: :User, optional: true

  has_many :interest_memberships
  has_many :members, -> { kept }, through: :interest_memberships, source: :user

  has_one :channel, as: :context

  after_create do |interest|
    InterestMembership.create(
      interest_id: interest.id,
      user_id: interest.creator_id,
      role: InterestMembership.roles[:member]
    )

    Channel.create(
      context: interest,
      title: 'general',
    )
  end

  def display_name
    discarded? ? "#{name} (inactive)" : name
  end
end
