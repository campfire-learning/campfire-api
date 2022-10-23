class Api::V1::PostsController < ApiController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts or /posts.json
  def index
    posts = Post
            .includes(:user, comments: [:user], reactions: [:user])
            .where(channel_id: params[:channel_id])
            .order(created_at: :desc)

    results = []
    posts.map do |post|
      post_hash = post.serializable_hash(
        include: [:user, { comments: { include: :user } }, { reactions: { include: :user } }]
      )
      if post.images.attached?
        post_hash['image_urls'] = post.images.map { |img| Rails.application.routes.url_helpers.url_for(img) }
      end
      results.push(post_hash)
    end

    render json: results
  end

  # GET /posts/1 or /posts/1.json
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    puts "original params: #{params}"
    puts "post params: #{post_params}"
    post = Post.new(post_params)
    if post.save
      post_hash = post.serializable_hash
      post_hash['image_urls'] = post.images.map { |img| Rails.application.routes.url_helpers.url_for(img) }
      render json: post_hash, status: :created
    else
      post.errors.each { |err| puts err.full_message }
      render json: post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if @post.comments.empty?
      @post.destroy
    else
      @post.discard # soft delete
    end

    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(
      :user_id,
      :chanel_id
      :post_text,
      :reply_to_id,
      images: []
    )
  end
end
