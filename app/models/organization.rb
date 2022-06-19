class Organization < ApplicationRecord
  has_many :users

  enum type: %i[university company high_school]
end
