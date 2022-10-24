class Api::V1::TabsController < ApiController
  before_action :set_tab, only: %i[ show edit update destroy ]
  before_action :validate_context_type, except: %i[destroy update]

  # GET /tabs or /tabs.json
  def index
    @tabs = Tab.all
  end

  # GET /tabs/1 or /tabs/1.json
  def show
  end

  # GET /tabs/new
  def new
    @tab = Tab.new
  end

  # GET /tabs/1/edit
  def edit
  end

  # POST /tabs or /tabs.json
  def create
    @tab = Tab.new(tab_params)

    if @tab.save
      render json: @tab, status: :created
    else
      render json: @tab.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tabs/1 or /tabs/1.json
  def update
    if @tab.update(tab_params)
      render json: @tab, status: :ok
    else
        render json: @tab.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tabs/1 or /tabs/1.json
  def destroy
    @tab.discard
        head :no_content
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tab
      @tab = Tab.find(params[:id])
    end

    def validate_context_type
      puts "Validating original params: #{params}"
      return if %w[Course Club].include? params[:context_type]
  
      render json: { message: "Wrong context type for channel: #{params[:context_type]}" },
             status: :unprocessable_entity
    end

    # Only allow a list of trusted parameters through.
    def tab_params
      params.fetch(:tab).permit(
        :tab_id,
        :context_type,
        :context_id,
        :name,
        :order,
        :tab_entity_type,
        :tab_entity_id,
        :source,
        :destination,
      )
    end
end
