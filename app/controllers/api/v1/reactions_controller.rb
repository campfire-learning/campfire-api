class Api::V1::ReactionsController < ApiController
  before_action :set_reaction, only: %i[show edit update destroy]
  before_action :set_post, only: %i[index]

  # GET /reactions or /reactions.json
  def index
    @reactions = @post.reactions
  end

  # GET /reactions/1 or /reactions/1.json
  def show
  end

  # GET /reactions/new
  def new
    @reaction = Reaction.new
  end

  # GET /reactions/1/edit
  def edit
  end

  # POST /reactions or /reactions.json
  def create
    reaction = Reaction.new(reaction_params)
    puts reaction_params.as_json

    if reaction.save
      render json: reaction, status: :created
    else
      puts reaction.errors.as_json
      render json: reaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reactions/1 or /reactions/1.json
  def destroy
    @reaction.destroy
    head :no_content
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_reaction
    @reaction = Reaction.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  # Only allow a list of trusted parameters through.
  def reaction_params
    params.require(:reaction).permit(:user_id, :post_id, :reaction)
  end
end
