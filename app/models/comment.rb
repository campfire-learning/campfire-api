class Comment < ApplicationRecord
  belongs_to :author, class_name: :User

  # polymorphic association - please note that a comment
  # can belong to another comment
  belongs_to :context, polymorphic: true
end
