class Api::V1::RichTextTabsController < ApiController
  before_action :set_rich_text_tab, only: %i[ show edit update destroy ]new

  # GET /rich_text_tabs or /rich_text_tabs.json
  def index
    @rich_text_tabs = RichTextTab.all
  end

  # GET /rich_text_tabs/1 or /rich_text_tabs/1.json
  def show
  end

  # GET /rich_text_tabs/new
  def new
    @rich_text_tab = RichTextTab.new
  end

  # GET /rich_text_tabs/1/edit
  def edit
  end

  # POST /rich_text_tabs or /rich_text_tabs.json
  def create
    @rich_text_tab = RichTextTab.new(rich_text_tab_params)

    if @rich_text_tab.save
      render json: @rich_text_tab, status: :created
    else
      render json: @rich_text_tab.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rich_text_tabs/1 or /rich_text_tabs/1.json
  def update
    if @rich_text_tab.update(rich_text_tab_params)
      render json: @rich_text_tab, status: :ok
    else
        render json: @rich_text_tab.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rich_text_tabs/1 or /rich_text_tabs/1.json
  def destroy
    @rich_text_tab.discard
        head :no_content
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tab
      @rich_text_tab = Tab.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rich_text_tab_params
      params.fetch(:rich_text_tab).permit(
        :rich_text_tab_id,
        :content,
      )
    end
end
