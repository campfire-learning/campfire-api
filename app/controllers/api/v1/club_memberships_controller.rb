class Api::V1::ClubMembershipsController < ApiController
  before_action :set_club_membership, only: %i[ show edit update destroy ]

  # GET /api/v1/club_memberships or /api/v1/club_memberships.json
  def index
    user = User.find(params[:user_id])
    render json: user.club_memberships.select(('*')).order(order: :asc).uniq
  end

  # POST /api/v1/club_memberships or /api/v1/club_memberships.json
  def create
    @club_membership = ClubMembership.new(club_membership_params)

    if @club_membership.save
      render json: @club_membership, status: :created
    else
      render json: @club_membership.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/club_memberships/1 or /api/v1/club_memberships/1.json
  def update
    User.transaction do
      source = params[:source]
      destination = params[:destination]
      if source && destination
        if source > destination
          user = User.find(params[:user_id])
          user.club_memberships.order(order: :asc).limit((source - destination).abs()).offset(destination).update_all("\"order\" = \"order\" + 1")
        elsif source < destination
          user = User.find(params[:user_id])
          user.club_memberships.order(order: :asc).limit((source - destination).abs()).offset(source + 1).update_all("\"order\" = \"order\" - 1")
        end
      end

      if @club_membership.update(club_membership_params)
        render json: @club_membership, status: :ok
      else
        render json: @club_membership.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /api/v1/club_memberships/1 or /api/v1/club_memberships/1.json
  def destroy
    @club_membership.discard
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_membership
      @club_membership = ClubMembership.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def club_membership_params
      params.fetch(:club_membership).permit(
        :club,
        :user,
        :order,
        :source,
        :destination,
        :user_role,
        :user_id
      )
    end
end
