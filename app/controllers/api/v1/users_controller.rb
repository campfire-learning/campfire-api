class Api::V1::UsersController < ApiController
  before_action :set_user, only: %i[show edit feed update destroy]

  # GET /users or /users.json
  def index
    if params[:channel_id]
      memberships = Channel.find(params[:channel_id]).channel_memberships
    elsif params[:course_id]
      memberships = Course.find(params[:course_id]).course_memberships
    elsif params[:club_id]
      memberships = Club.find(params[:club_id]).club_memberships
    end

    render json: memberships, include: :user
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      # add all users to the general channel so they can be engaged from the very beginning
      ChannelMembership.create(
        channel_id: Channel.campfire_general.id,
        user_id: @user.id,
        role: ChannelMembership.roles[:memeber]
      )

      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/1/feed
  def feed
    course_ids = @user.courses.limit(25).map(&:id)
    channel_ids = @user.channels.limit(25).map(&:id)
    posts = Post
            .includes(:author, comments: [:author], likes: [:user])
            .where('context_type = "Course" and context_id in (?)', course_ids)
            .or(Post.where('context_type = "Channel" and context_id in (?)', channel_ids))
            .where('created_at > ?', 7.days.ago)
            .order(created_at: :desc)
            .limit(100)

    results = []
    posts.find_each do |post|
      post_hash = post.serializable_hash(
        include: [:author, { comments: { include: :author } }, { likes: { include: :user } }]
      )
      if post.images.attached?
        post_hash['image_urls'] = post.images.map { |img| Rails.application.routes.url_helpers.url_for(img) }
      end
      results.push(post_hash)
    end

    # render json: results
    render json: []
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.fetch(:user, {})
  end
end
