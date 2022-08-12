class Comment < ApplicationRecord
  belongs_to :creator, class_name: :User

  # polymorphic association
  belongs_to :context, polymorphic: true
end
