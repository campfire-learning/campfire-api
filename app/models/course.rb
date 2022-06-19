class Course < ApplicationRecord
  belongs_to :creator
  belongs_to :owner
end
