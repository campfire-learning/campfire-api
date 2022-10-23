class Institution < ApplicationRecord
  has_many :users
  has_many :courses
  has_many :clubs
  has_many :groups

  enum institution_type: { university: 'university' }

  after_create do |institution|
    Group.create(
      institution_id: institution.id,
      title: 'general',
    )
  end
end