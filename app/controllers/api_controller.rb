class ApiController < ApplicationController
  # equivalent of devise's authenticate_user!
  before_action :doorkeeper_authorize!

  # skip checking of CSRF token authenticity
  skip_before_action :verify_authenticity_token

  respond_to :json

  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
  end
end
