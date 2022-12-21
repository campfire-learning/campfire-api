class Api::V1::ClubsController < ApiController
  before_action :set_club, only: %i[show update destroy]

  # GET /clubs or /clubs.json
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      clubs = user.clubs
                  .select(('clubs.*, club_memberships.id as membership_id, club_memberships.`order`'))
                  .order(order: :asc)
      render json: clubs
    end
  end

  # GET /clubs/1 or /clubs/1.json
  def show
    render json: @club
  end

  # POST /clubs or /clubs.json
  def create
    @club = Club.new(club_params.merge(creator_id: params[:user_id]))

    if @club.save
      render json: @club, status: :created
    else
      render json: @club.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clubs/1 or /clubs/1.json
  def update
    if @club.update(club_params)
      render json: @club, status: :ok
    else
      render json: @club.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clubs/1 or /clubs/1.json
  def destroy
    @club.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_club
    @club = Club.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def club_params
    params.require(:club).permit(
      :institution_id,
      :title,
      :icon,
      :creator_id,
      :public,
      :password
    )
  end
end
