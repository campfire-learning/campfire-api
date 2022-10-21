class Group < ApplicationRecord
  include Discard::Model

  belongs_to :institution
  belongs_to :creator, class_name: :User

  has_many :group_memberships
  has_many :members, -> { kept }, through: :group_memberships, source: :user

  has_one :channels, as: :context

  # TODO: should be per school (stanford_general, berkely_general)
  def self.campfire_general
    Group.first
  end

  after_create do |group|
    GroupMembership.create(
      group_id: group.id,
      user_id: group.creator_id,
      role: GroupMembership.roles[:member]
    )
  end

  def display_name
    discarded? ? "#{name} (inactive)" : name
  end
end
