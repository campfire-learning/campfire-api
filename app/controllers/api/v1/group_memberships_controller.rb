class Api::V1::GroupMembershipsController < ApiController
  before_action :set_group_membership, only: %i[ show edit update destroy ]

  # GET /api/v1/group_memberships or /api/v1/group_memberships.json
  def index
    user = User.find(params[:user_id])
    render json: user.group_memberships.select(('*')).order(order: :asc).uniq
  end

  # POST /api/v1/group_memberships or /api/v1/group_memberships.json
  def create
    @group_membership = GroupMembership.new(group_membership_params)

    if @group_membership.save
      render json: @group_membership, status: :created
    else
      render json: @group_membership.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/group_memberships/1 or /api/v1/group_memberships/1.json
  def update
    source = params[:source]
    destination = params[:destination]
    if source && destination
      if source > destination
        user = User.find(params[:user_id])
        user.group_memberships.order(order: :asc).limit((source - destination).abs()).offset(destination).update_all("\"order\" = \"order\" + 1")
      elsif source < destination
        user = User.find(params[:user_id])
        user.group_memberships.order(order: :asc).limit((source - destination).abs()).offset(source + 1).update_all("\"order\" = \"order\" - 1")
      end
    end

    if @group_membership.update(group_membership_params)
      render json: @group_membership, status: :ok
    else
      render json: @group_membership.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/group_memberships/1 or /api/v1/group_memberships/1.json
  def destroy
    @group_membership.discard
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_membership
      @group_membership = GroupMembership.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_membership_params
      params.fetch(:group_membership).permit(
        :group,
        :user,
        :order,
        :source,
        :destination,
        :user_role,
        :user_id
      )
    end
end
