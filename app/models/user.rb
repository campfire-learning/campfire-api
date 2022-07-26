# frozen_string_literal: true

# The most important class in the whole application
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable, :confirmable, :lockable

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  enum user_type: { instructor_type: 1, assistant_type: 2, student_type: 3 }

  belongs_to :organization, optional: true
  has_many :owned_courses, foreign_key: :owner_id, class_name: :Course
  has_many :course_memberships
  has_many :courses, through: :course_memberships
  has_many :group_memberships
  has_many :groups, through: :group_memberships

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.validate_password?(password) ? user : nil
  end
end
