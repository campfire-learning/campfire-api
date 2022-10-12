class Api::V1::CourseMembershipsController < ApplicationController
  before_action :set_course_membership, only: %i[ show edit update destroy ]

  # GET /api/v1/course_memberships or /api/v1/course_memberships.json
  def index
    user = User.find(params['user_id'])
    render json: user.course_memberships.select(('*')).order(order: :asc).uniq
  end

  # POST /api/v1/course_memberships or /api/v1/course_memberships.json
  def create
    @course_membership = CourseMembership.new(course_membership_params)

    if @course.save
      render json: @course, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/course_memberships/1 or /api/v1/course_memberships/1.json
  def update
    logger.debug(params)
    # if @course_membership.update(course_membership_params)
    #   render json: @course_membership, status: :ok
    # else
    #   render json: @course_membership.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /api/v1/course_memberships/1 or /api/v1/course_memberships/1.json
  def destroy
    @course_membership.discard
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_membership
      @course_membership = CourseMembership.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_membership_params
      params.fetch(:course_membership).permit(
        :course,
        :user,
        :order,
        :academic_role,
        :user_role
      )
    end
end
