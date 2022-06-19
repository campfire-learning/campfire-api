class Course < ApplicationRecord
  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User
end
