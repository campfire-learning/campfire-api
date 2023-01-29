class Api::V1::AssignmentsController < ApiController
  before_action :set_assignment, only: %i[show edit update destroy]

  # GET /assignments or /assignments.json
  def index
    assignments = Assignment.all
    render json: assignments
  end

  # GET /assignments/1 or /assignments/1.json
  def show
    @assignment = Assignment.includes(:uploads_attachments).find(params[:id])

    if @assignment&.uploads&.attached?
      assignment_hash = @assignment.serializable_hash
      assignment_hash["uploads_data"] = @assignment.uploads_data
      render json: assignment_hash
    else
      render json: @assignment
    end
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments or /assignments.json
  def create
    assignment = Assignment.new(assignment_params)

    if assignment.save
      render json: assignment, status: :created, location: @assignment
    else
      render json: assignment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assignments/1 or /assignments/1.json
  def update
    if @assignment.update(assignment_params)
      params[:uploads] && @assignment.uploads.attach(params[:uploads])
      render json: @assignment, status: :ok
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /assignments/1 or /assignments/1.json
  def destroy
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to assignments_url, notice: "Assignment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def assignment_params
    params.require(:assignment).permit(:id, :title, :course_id, :rich_text, :assignment_type, :due_time)
  end
end
