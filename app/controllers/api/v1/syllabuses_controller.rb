class Api::V1::SyllabusesController < ApiController
  before_action :set_syllabus, only: %i[show edit update destroy]

  # GET /syllabuses
  def index
    @syllabus = Syllabus.all
  end

  # GET /syllabuses/1
  def show
    @syllabus = Syllabus.includes(:uploads).find(params[:id])
    render json: @syllabus, include: :uploads
  end

  # GET /syllabuses/new
  def new
    @syllabus = Syllabus.new
  end

  # GET /syllabuses/1/edit
  def edit
  end

  # POST /syllabuses
  def create
    @syllabus = Syllabus.new(syllabus_params)

    if @syllabus.save
      render json: @syllabus, status: :created
    else
      @syllabus.errors.each { |err| puts err.full_message }
      render json: @syllabus.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /syllabuses/1
  def update
    if @syllabus.update(syllabus_params)
      params[:uploads] && @syllabus.uploads.attach(params[:uploads])
      render json: @syllabus, status: :ok
    else
      render json: @syllabus.errors, status: :unprocessable_entity
    end
  end

  # DELETE /syllabuses/1
  def destroy
    @syllabus.discard
    head :no_content
  end

  private

  def set_syllabus
    @syllabus = Syllabus.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def syllabus_params
    params.fetch(:syllabus).permit(
      :id,
      :rich_text,
      :uploads,
      :course_id
    )
  end
end
