class Post < ApplicationRecord
  belongs_to :creator, class_name: :User

  # "context_type" refers to the kind of context where the post is published;
  # "home" refers to the case when a user publishes a post in his/her home
  enum context_type: %i[course_context group_context home_context]
end
