# frozen_string_literal: true

# The most important class in the whole application
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable, :confirmable, :lockable

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  enum user_type: { admin: 1, bot: 2, professor: 3, instructor: 4, assistant: 5, student: 6 }

  belongs_to :organization, optional: true
  belongs_to :time_zone
  has_many :owned_courses, foreign_key: :owner_id, class_name: :Course
  has_many :course_memberships
  has_many :courses, through: :course_memberships
  has_many :owned_clubs, foreign_key: :owner_id, class_name: :Channel
  has_many :club_memberships
  has_many :clubs, through: :club_memberships
  has_many :owned_channels, foreign_key: :owner_id, class_name: :Channel
  has_many :channel_memberships
  has_many :channels, through: :channel_memberships

  def name
    "#{first_name} #{last_name}"
  end

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.validate_password?(password) ? user : nil
  end
end
