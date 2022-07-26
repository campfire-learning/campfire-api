class Post < ApplicationRecord
  belongs_to :creator, class_name: :User

  # "context_type" refers to the kind of context where the post is published;
  # 1. "in_course" refers to the case when a post is published to a class
  # 2. "in_group" - when a post is published to a group
  # 3. "in_user" - when a post is published in a user's home, either by the user
  # himself/herself or by a friend
  # Rails does its magic and generates methods based on enum strings like so:
  # post1.in_course? post2.in_group?
  enum context_type: { in_course: 1, in_group: 2, in_user: 3 }
end
