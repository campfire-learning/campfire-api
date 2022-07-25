class Api::V1::KlassesController < ApiController
  before_action :set_klass, only: %i[show update destroy]

  # GET /klasses or /klasses.json
  def index
    user = User.find(params['user_id'])
    klasses = user.klasses.map do |klass|
      klass.course.as_json.merge({ start_date: klass.start_date })
    end

    render json: { klasses: klasses }
  end

  # GET /klasses/1 or /klasses/1.json
  def show
    render json: @klass
  end

  # POST /klasses or /klasses.json
  def create
    @klass = Klass.new(klass_params)

    if @klass.save
      render json: @klass, status: :created
    else
      render json: @klass.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /klasses/1 or /klasses/1.json
  def update
    if @klass.update(klass_params)
      render json: @klass, status: :ok
    else
      render json: @klass.errors, status: :unprocessable_entity
    end
  end

  # DELETE /klasses/1 or /klasses/1.json
  def destroy
    @klass.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_klass
    @klass = Klass.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def klass_params
    params.require(:klass).permit(:course_id, :creator_id, :owner_id, :start_date)
  end
end
