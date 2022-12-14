class Api::V1::InterestMembershipsController < ApiController
  before_action :set_interest_membership, only: %i[ show edit update destroy ]

  # GET /api/v1/interest_memberships or /api/v1/interest_memberships.json
  def index
    user = User.find(params[:user_id])
    render json: user
      .interest_memberships
      .select(('*'))
      .order(order: :asc)
      .uniq
  end

  # POST /api/v1/interest_memberships or /api/v1/interest_memberships.json
  def create
    @interest_membership = InterestMembership.new(interest_membership_params)

    if @interest_membership.save
      render json: @interest_membership, status: :created
    else
      render json: @interest_membership.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/interest_memberships/1 or /api/v1/interest_memberships/1.json
  def update
    User.transaction do
      source = params[:source]
      destination = params[:destination]
      if source && destination
        if source > destination
          user = User.find(params[:user_id])
          user
            .interest_memberships
            .order(order: :asc)
            .limit((source - destination).abs())
            .offset(destination)
            .update_all("\"order\" = \"order\" + 1")
        elsif source < destination
          user = User.find(params[:user_id])
          user
            .interest_memberships
            .order(order: :asc)
            .limit((source - destination).abs())
            .offset(source + 1)
            .update_all("\"order\" = \"order\" - 1")
        end
      end

      if @interest_membership.update(interest_membership_params)
        render json: @interest_membership, status: :ok
      else
        render json: @interest_membership.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /api/v1/interest_memberships/1 or /api/v1/interest_memberships/1.json
  def destroy
    @interest_membership.discard
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interest_membership
      @interest_membership = InterestMembership.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def interest_membership_params
      params.fetch(:interest_membership).permit(
        :interest_id,
        :user_id,
        :order,
        :source,
        :destination,
        :role,
        :banned,
      )
    end
end
