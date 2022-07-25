class Api::V1::GroupsController < ApiController
  before_action :set_group, only: %i[show update destroy]

  # GET /groups or /groups.json
  def index
    @groups = Group.where(owner_id: params['user_id'])
    render json: @groups
  end

  # GET /groups/1 or /groups/1.json
  def show
    render json: @group
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)

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
    @group.destroy
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