# frozen_string_literal: true

# Controller for API endpoints
class ApiController < ApplicationController
  # uncomment before deploying to production
  before_action :doorkeeper_authorize!

  # skip checking of CSRF token authenticity
  skip_before_action :verify_authenticity_token

  respond_to :json

  def current_user
    return unless doorkeeper_token

    @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
  end
end
