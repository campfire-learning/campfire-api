class Api::V1::AssignmentsController < ApiController
  before_action :set_assignment, only: %i[show edit update destroy]

  # GET /assignments or /assignments.json
  def index
    assignments = Assignment.all
    render json: assignments
  end

  # GET /assignments/1 or /assignments/1.json
  def show
    render json: @assignment
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
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to assignment_url(@assignment), notice: "Assignment was successfully updated." }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
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
    params.require(:assignment).permit(:title, :course_id, :rich_text, :due_time)
  end
end
