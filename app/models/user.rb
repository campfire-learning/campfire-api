# frozen_string_literal: true

# The most important class in the whole application
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable, and :omniauthable
  # Add them if needed.
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable, :lockable

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  enum user_type: { admin: 1, bot: 2, professor: 3, instructor: 4, assistant: 5, student: 6 }

  belongs_to :organization, optional: true
  belongs_to :time_zone
  has_many :owned_courses, foreign_key: :owner_id, class_name: :Course
  has_many :course_memberships
  has_many :courses, through: :course_memberships
  has_many :owned_groups, foreign_key: :owner_id, class_name: :Group
  has_many :group_memberships
  has_many :groups, through: :group_memberships

  def name
    "#{first_name} #{last_name}"
  end

  def self.authenticate(email, password)
    user = User.find_for_authentication(email:)
    user&.valid_password?(password) ? user : nil
  end
end
