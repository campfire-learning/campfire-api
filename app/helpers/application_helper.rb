module ApplicationHelper
  def is_admin?
    return if current_user&.admin?

    respond_to do |format|
      format.json { render json: { error: 'You are not authorized!'} }
      format.html { redirect_to root_path, notice: 'You are not authorized!' }
    end
  end
end
