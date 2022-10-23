class User < ApplicationRecord
  include Discard::Model

  # Include devise modules. Others available are (add if needed):
  #   :confirmable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable, :lockable

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  enum user_type: { admin: 'admin', bot: 'bot', instructor: 'instructor', alumni: 'alumni', student: 'student' }

  belongs_to :institution
  has_many :course_memberships
  has_many :courses, through: :course_memberships
  has_many :club_memberships
  has_many :clubs, through: :club_memberships
  has_many :interest_memberships
  has_many :interests, through: :interest_memberships

  after_discard do
    interests.discard_all
    clubs.discard_all
    courses.discard_all
  end

  after_undiscard do
    interests.undiscard_all
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

  def self.marshmallow
    User.where(email: 'marshmallow@campfire.com').first
  end
end
