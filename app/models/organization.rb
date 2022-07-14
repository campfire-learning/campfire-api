class Organization < ApplicationRecord
  has_many :users

  enum organization_type: { university: 1, company: 2, high_school: 3 }
end
