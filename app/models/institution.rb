class Institution < ApplicationRecord
  has_many :users
  has_many :courses
  has_many :clubs
  has_many :groups

  enum institution_type: { university: 'university' }
end
