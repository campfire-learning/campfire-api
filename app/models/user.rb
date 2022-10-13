# frozen_string_literal: true

# The most important class in the whole application
class User < ApplicationRecord
  include Discard::Model

  # Include devise modules. Others available are (add if needed):
  #   :confirmable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable, :lockable

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  enum user_type: { admin: 1, bot: 2, instructor: 3, assistant: 4, student: 5 }

  belongs_to :organization, optional: true
  belongs_to :time_zone, optional: true
  has_many :owned_courses, foreign_key: :owner_id, class_name: :Course
  has_many :course_memberships
  has_many :courses, through: :course_memberships
  has_many :owned_clubs, foreign_key: :owner_id, class_name: :Group
  has_many :club_memberships
  has_many :clubs, through: :club_memberships
  has_many :owned_groups, foreign_key: :owner_id, class_name: :Group
  has_many :group_memberships
  has_many :groups, through: :group_memberships

  after_discard do
    groups.discard_all
    clubs.discard_all
    courses.discard_all
  end

  after_undiscard do
    groups.undiscard_all
    clubs.undiscard_all
    courses.undiscard_all
  end

  def name
    discarded_status = discarded? ? ' (inactive)' : ''
    "#{first_name} #{last_name}#{discarded_status}"
  end

  def self.authenticate(email, password)
    user = User.find_for_authentication(email:)
    user&.valid_password?(password) ? user : nil
  end
end
