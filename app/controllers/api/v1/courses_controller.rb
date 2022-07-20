class Api::V1::CoursesController < ApiController
  before_action :set_course, only: %i[show edit update destroy]

  # GET /courses or /courses.json
  def index
    @courses = Course.where(owner_id: params['user_id'])
    render json: @courses
  end

  # GET /courses/1 or /courses/1.json
  def show
    render json: @course
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    # foo bar
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    if @course.save
      render json: @course, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    if @course.update(course_params)
      render json: @course, status: :ok
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit(:creator_id, :owner_id, :title, :description)
  end
end
