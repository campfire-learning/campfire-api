class Api::V1::GroupsController < ApiController
  before_action :set_group, only: %i[show update destroy]

  # GET /groups or /groups.json
  def index
    user = User.find(params['user_id'])
    render json: user.groups.select(('groups.*, group_memberships.id as membership_id, group_memberships.`order`')).order(order: :asc).uniq
  end

  # GET /groups/1 or /groups/1.json
  def show
    render json: @group
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params.merge(creator_id: params[:user_id], owner_id: params[:user_id]))

    if @group.save
      render json: @group, status: :created
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    if @group.update(group_params)
      render json: @group, status: :ok
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.discard
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :creator_id, :owner_id, :description, :public)
  end
end
