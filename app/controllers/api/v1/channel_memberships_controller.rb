class Api::V1::ChannelMembershipsController < ApiController
  before_action :set_chanel_membership, only: %i[ show edit update destroy ]new

  # GET /chanel_memberships or /chanel_memberships.json
  def index
    @chanel_memberships = ChannelMembership.all
  end

  # GET /chanel_memberships/1 or /chanel_memberships/1.json
  def show
  end

  # GET /chanel_memberships/new
  def new
    @chanel_membership = ChannelMembership.new
  end

  # GET /chanel_memberships/1/edit
  def edit
  end

  # POST /chanel_memberships or /chanel_memberships.json
  def create
    @chanel_membership = ChannelMembership.new(chanel_membership_params)

    if @chanel_membership.save
      render json: @chanel_membership, status: :created
    else
      render json: @chanel_membership.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chanel_memberships/1 or /chanel_memberships/1.json
  def update
    if @chanel_membership.update(chanel_membership_params)
      render json: @chanel_membership, status: :ok
    else
        render json: @chanel_membership.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chanel_memberships/1 or /chanel_memberships/1.json
  def destroy
    @chanel_membership.discard
        head :no_content
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tab
      @chanel_membership = Tab.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chanel_membership_params
      params.fetch(:chanel_membership).permit(
        :chanel_membership_id,
        :user_id,
        :channel_id,
        :mention_count,
        :new_message_count,
        :last_visited,
      )
    end
end
