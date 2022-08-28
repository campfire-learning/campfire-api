class Api::V1::CommentsController < ApiController
  before_action :set_comment, only: %i[show edit update destroy]

  # POST /comments or /comments.json
  def create
    raise 'Non-post comments are not yet implemented!' unless params['post_id']

    comment = Comment.new(comment_params
      .merge({ context_type: 'Post', context_id: params['post_id'], author_id: params['user_id'] })
      .except(:user_id, :post_id, :comment))
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:post_id, :comment_text, :user_id)
  end
end
