class Api::V1::LikesController < ApiController
  before_action :set_like, only: %i[show edit update destroy]
  before_action :set_post, only: %i[index]

  # GET /likes or /likes.json
  def index
    @likes = @post.likes
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create
    like = Like.new(like_params)
    puts like_params.as_json

    if like.save
      render json: like, status: :created
    else
      puts like.errors.as_json
      render json: like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy
    head :no_content
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  # Only allow a list of trusted parameters through.
  def like_params
    params.require(:like).permit(:user_id, :likable_type, :likable_id)
  end
end
