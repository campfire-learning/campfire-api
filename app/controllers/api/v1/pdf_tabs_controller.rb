class Api::V1::PdfTabsController < ApiController
  before_action :set_pdf_tab, only: %i[ show edit update destroy ]

  # GET /pdf_tabs or /pdf_tabs.json
  def index
    @pdf_tabs = PdfTab.all
  end

  # GET /pdf_tabs/1 or /pdf_tabs/1.json
  def show
  end

  # GET /pdf_tabs/new
  def new
    @pdf_tab = PdfTab.new
  end

  # GET /pdf_tabs/1/edit
  def edit
  end

  # POST /pdf_tabs or /pdf_tabs.json
  def create
    @pdf_tab = PdfTab.new(pdf_tab_params)

    if @pdf_tab.save
      render json: @pdf_tab, status: :created
    else
      render json: @pdf_tab.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pdf_tabs/1 or /pdf_tabs/1.json
  def update
    if @pdf_tab.update(pdf_tab_params)
      render json: @pdf_tab, status: :ok
    else
      render json: @pdf_tab.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pdf_tabs/1 or /pdf_tabs/1.json
  def destroy
    @pdf_tab.discard
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tab
    @pdf_tab = Tab.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def pdf_tab_params
    params.fetch(:pdf_tab).permit(
      :pdf_tab_id,
    )
  end
end
