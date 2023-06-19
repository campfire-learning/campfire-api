class Api::V1::GradesController < ApiController
  before_action :set_grade, only: %i[ show update destroy ]

  # GET /grades
  # GET /grades.json
  def index
    @grades = Grade.includes(:gradable, :user).all
    render json: @grades, include: [:gradable, :user]
  end

  # GET /grades/1
  # GET /grades/1.json
  def show
  end

  # POST /grades
  # POST /grades.json
  def create
    @grade = Grade.new(grade_params)

    if @grade.save
      render :show, status: :created, location: @grade
    else
      render json: @grade.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /grades/1
  # PATCH/PUT /grades/1.json
  def update
    if @grade.update(grade_params)
      render :show, status: :ok, location: @grade
    else
      render json: @grade.errors, status: :unprocessable_entity
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.json
  def destroy
    @grade.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_grade
    @grade = Grade.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def grade_params
    params.fetch(:grade, {})
  end
end
