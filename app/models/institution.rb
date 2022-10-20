class Institution < ApplicationRecord
  has_many :users

  enum institution_type: { university: 'university', company: 'company', high_school: 'high_school' }
end
