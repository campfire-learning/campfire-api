class Api::V1::ChannelsController < ApiController
    before_action :set_channel, only: %i[show edit update destroy]
    before_action :validate_context_type, except: %i[destroy update]
  
    # GET /channels or /channels.json
    def index
        render json: channels
            .where(context_type: params[:context_type], context_id: params[:context_id])
            .order(order: :asc)

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

    # PATCH/PUT /channels/1 or /channels/1.json
    def update
        User.transaction do
            source = params[:source]
            destination = params[:destination]
            if source && destination
              if source > destination
                channels.
                    .where(context_type: params[:context_type], context_id: params[:context_id])
                    .order(order: :asc)
                    .limit((source - destination).abs())
                    .offset(destination)
                    .update_all("\"order\" = \"order\" + 1")
              elsif source < destination
                .where(context_type: params[:context_type], context_id: params[:context_id])
                    .order(order: :asc)
                    .limit((source - destination).abs())
                    .offset(source + 1)
                    .update_all("\"order\" = \"order\" - 1")
              end
            end

            if @channel.update(channel_params)
                render json: @channel, status: :ok
            else
                render json: @channel.errors, status: :unprocessable_entity
            end
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

      def validate_context_type
        puts "Validating original params: #{params}"
        return if %w[Interest Course Club].include? params[:context_type]
    
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
          :destination,
        )
      end
  end
  