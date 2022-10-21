class Post < ApplicationRecord
  include Discard::Model

  belongs_to :user
  belongs_to :channel

  # Since posts are soft deleted it doesn't make sense to destroy these as they won't actually be dangling
  has_many :reactions
  has_many_attached :images

  def image_urls
    images.map { |image| Rails.application.routes.url_helpers.url_for(image) }
  end
end
