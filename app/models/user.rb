# The most important class in the whole application
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable, :confirmable, :lockable

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  enum user_type: { instructor_type: 1, student_type: 2, assistant_type: 3 }

  belongs_to :organization, optional: true
  has_many :courses, foreign_key: :owner_id

  has_many :klass_memberships
  has_many :klasses, through: :klass_memberships
  has_many :group_memberships
  has_many :groups, through: :group_memberships

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.validate_password?(password) ? user : nil
  end
end
