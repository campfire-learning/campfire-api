class Api::V1::ChannelsController < ApiController
  before_action :set_channel, only: %i[show edit update destroy]
  before_action :validate_context, only: %i[index create]

  # GET /channels or /channels.json
  def index
    case params[:context_type]
    when "Course"
      render json: Course.find(params[:context_id]).channels
    when "Club"
      render json: Club.find(params[:context_id]).channels
    else
      render json: [Interest.find(params[:context_id]).channel]
    end
  end

  # GET /channels/1 or /channels/1.json
  def show; end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit; end

  # POST /channels or /channels.json
  def create
    @channel = Channel.new(channel_params)

    if @channel.save
      render json: @channel, status: :created
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /channels/1 or /channels/1.json
  def destroy
    @channel.discard
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_channel
    @channel = Channel.find(params[:id])
  end

  def validate_context
    puts "Validating original params: #{params}"
    unless params[:context_id]
      render json: { message: "Missing context ID in channels query!" },
             status: :unprocessable_entity
    end

    unless params[:context_type]
      render json: { message: "Missing context type in channels query!" },
             status: :unprocessable_entity
    end

    return if %w[Interest Course Club].include?(params[:context_type])

    render json: { message: "Wrong context type for channel: #{params[:context_type]}" },
           status: :unprocessable_entity
  end

  # Only allow a list of trusted parameters through.
  def channel_params
    params.fetch(:channel).permit(
      :channel_id,
      :context_type,
      :context_id,
      :title,
      :description,
      :order,
      :source,
      :destination
    )
  end
end
