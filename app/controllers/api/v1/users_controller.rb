class Api::V1::UsersController < ApiController
  before_action :set_user, only: %i[show edit feed update destroy]
  # skip_before_action :doorkeeper_authorize!, only: %i[login]

  include DoorkeeperUserRenderable

  # GET /users or /users.json
  def index
    if params[:interest_id]
      memberships = Interest.find(params[:interest_id]).interest_memberships
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
    # The action of creating a user is called registration!
    # That is why it is executed in registrations#create, not here.
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

  # POST /users/login
  def login
    client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
    unless client_app
      return render json: { error: I18n.t('doorkeeper.errors.messages.invalid_client') }, status: :unauthorized
    end

    user = User.authenticate(params[:email], params[:password])
    if user
      render json: render_user(user, client_app), status: :ok
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  # GET /users/1/feed
  def feed
    course_ids = @user.courses.limit(25).map(&:id)
    interest_ids = @user.interests.limit(25).map(&:id)
    posts = Post
            .includes(:user, comments: [:user], reactions: [:user])
            .where('context_type = "Course" and context_id in (?)', course_ids)
            .or(Post.where('context_type = "Interest" and context_id in (?)', interest_ids))
            .where('created_at > ?', 7.days.ago)
            .order(created_at: :desc)
            .limit(100)

    results = []
    posts.find_each do |post|
      post_hash = post.serializable_hash(
        include: [:user, { comments: { include: :user } }, { reactions: { include: :user } }]
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
    @user.discard

    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :first_name,
      :last_name,
      :user_type,
      :institution_id,
      :client_id
    )
  end
end
