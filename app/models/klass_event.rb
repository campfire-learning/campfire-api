class KlassEvent < ApplicationRecord
  belongs_to :klass
  belongs_to :course_event
end
