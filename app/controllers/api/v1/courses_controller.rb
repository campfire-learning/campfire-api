class Api::V1::CoursesController < ApiController
  before_action :set_course, only: %i[show update destroy]

  # GET /courses or /courses.json
  def index
    user = User.find(params['user_id'])
    render json: user.courses
      .select(('courses.*, course_memberships.id as membership_id, course_memberships.`order`'))
      .order(order: :asc)
      .uniq
  end

  # GET /courses/1 or /courses/1.json
  def show
    @course = Course.includes(:events).find(params[:id])
    render json: @course, include: [:events]
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(
      course_params.merge(creator_id: params[:user_id])
    )

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
    @course.discard
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit(
      :institution,
      :title,
      :icon,
      :code,
      :department,
      :creator_id,
      :public,
      :password,
      :year,
      :term,
    )
  end
end
