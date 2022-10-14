class Post < ApplicationRecord
  include Discard::Model

  belongs_to :user

  # "context" refers to the location where the post is published:
  # 1. "course" - a post is published to a course
  # 2. "club" - a post is published to a group
  # 3. "group" - a post is published to a group
  # 4. "post" - a post is published as a comment to another post
  # we need polymorphic association to support this flexibility (instead
  # of creating 3 different types of posts).
  belongs_to :context, polymorphic: true

  # comments are just posts attached to another post
  has_many :comments, class_name: :Post, as: :context
  has_many :likes, as: :likable, dependent: :destroy

  has_many_attached :images, dependent: :destroy

  def image_urls
    images.map { |image| Rails.application.routes.url_helpers.url_for(image) }
  end
end
