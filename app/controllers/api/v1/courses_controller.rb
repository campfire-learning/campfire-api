class Api::V1::CoursesController < ApiController
  before_action :set_course, only: %i[show update destroy]

  # GET /courses or /courses.json
  def index
    user = User.find(params['user_id'])
    render json: user.courses.order(created_at: :desc).uniq
  end

  # GET /courses/1 or /courses/1.json
  def show
    render json: @course
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(
      course_params.merge(creator_id: params[:user_id], owner_id: params[:user_id])
    )

    if @course.save
      CourseMembership.create(
        course_id: @course.id,
        user_id: params[:user_id],
        role: CourseMembership.roles[:instructor]
      )
      render json: @course, status: :created
    else
      @course.errors.each { |err| puts err.full_message }
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    if @course.update(course_params)
      if params[:events].size.positive?
        events = params[:events].map { |event| event.merge(course_id: @course.id) }
        CourseEvent.upsert_all(events)
      end
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
    params.require(:course).permit(:creator_id, :owner_id, :title, :description, :year, :term, :location, :start_date)
  end
end
