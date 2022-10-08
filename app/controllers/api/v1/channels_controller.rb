class Api::V1::ChannelsController < ApiController
  before_action :set_channel, only: %i[show update destroy]

  # GET /channels or /channels.json
  def index
    user = User.find(params['user_id'])
    render json: user.channels
  end

  # GET /channels/1 or /channels/1.json
  def show
    render json: @channel
  end

  # POST /channels or /channels.json
  def create
    @channel = Channel.new(channel_params.merge(creator_id: params[:user_id], owner_id: params[:user_id]))

    if @channel.save
      render json: @channel, status: :created
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /channels/1 or /channels/1.json
  def update
    if @channel.update(channel_params)
      render json: @channel, status: :ok
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /channels/1 or /channels/1.json
  def destroy
    @channel.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_channel
    @channel = Channel.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def channel_params
    params.require(:channel).permit(:name, :creator_id, :owner_id, :description, :public)
  end
end
