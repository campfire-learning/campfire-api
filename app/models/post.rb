class Post < ApplicationRecord
  belongs_to :creator, class_name: :User

  # "context" refers to the location where the post is published:
  # 1. "course" - a post is published to a course
  # 2. "group" - a post is published to a group
  # 3. "user" - a post is published in a user's home, either by the user
  # themself or by a friend
  # we need polymorphic association to support this flexibility (instead
  # of creating 3 different types of posts).
  belongs_to :context, polymorphic: true
end
