class Organization < ApplicationRecord
  has_many :users

  enum organization_type: %i[university company high_school]
end
