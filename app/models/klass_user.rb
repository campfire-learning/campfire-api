class KlassMembership < ApplicationRecord
  belongs_to :klass
  belongs_to :user

  enum role: { instructor: 1, teaching_assistant: 2, student: 3 }
end
