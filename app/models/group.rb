class Group < ApplicationRecord
  include Discard::Model

  belongs_to :institution
  belongs_to :creator, class_name: :User, optional: true

  has_many :group_memberships
  has_many :members, -> { kept }, through: :group_memberships, source: :user

  has_one :channel, as: :context

  after_create do |group|
    GroupMembership.create(
      group_id: group.id,
      user_id: group.creator_id,
      role: GroupMembership.roles[:member]
    )

    Channel.create(
      context: group,
      title: 'general',
    )
  end

  def display_name
    discarded? ? "#{name} (inactive)" : name
  end
end
