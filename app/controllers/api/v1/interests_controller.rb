class Api::V1::InterestsController < ApiController
  before_action :set_interest, only: %i[show update destroy]

  # GET /interests or /interests.json
  def index
    user = User.find(params['user_id'])
    render json: user.interests
      .select(('interests.*, interest_memberships.id as membership_id, interest_memberships.`order`'))
      .order(order: :asc)
      .uniq
  end

  # GET /interests/1 or /interests/1.json
  def show
    render json: @interest
  end

  # POST /interests or /interests.json
  def create
    @interest = Interest.new(interest_params.merge(creator_id: params[:user_id],))

    if @interest.save
      render json: @interest, status: :created
    else
      render json: @interest.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /interests/1 or /interests/1.json
  def update
    if @interest.update(interest_params)
      render json: @interest, status: :ok
    else
      render json: @interest.errors, status: :unprocessable_entity
    end
  end

  # DELETE /interests/1 or /interests/1.json
  def destroy
    @interest.discard
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_interest
    @interest = Interest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def interest_params
    params.require(:interest).permit(
      :institution_id,
      :title, 
      :icon,
      :creator_id, 
      :public,
      :password,
    )
  end
end
