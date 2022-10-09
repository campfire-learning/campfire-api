class Post < ApplicationRecord
  belongs_to :author, class_name: :User

  # "context" refers to the location where the post is published:
  # 1. "course" - a post is published to a course
  # 2. "group" - a post is published to a group
  # 3. "user" - a post is published in a user's home, either by the user
  # themself or by a friend
  # we need polymorphic association to support this flexibility (instead
  # of creating 3 different types of posts).
  belongs_to :context, polymorphic: true

  # comments are just posts attached to another post
  has_many :comments, class_name: :Post, as: :context
  has_many :likes, as: :likable

  has_many_attached :images

  def image_urls
    images.map { |image| Rails.application.routes.url_helpers.url_for(image) }
  end
end
