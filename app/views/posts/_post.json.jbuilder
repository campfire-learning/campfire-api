json.extract! post, :id, :creator_id, :post_text, :context_type, :pinned, :created_at, :updated_at
json.url post_url(post, format: :json)
