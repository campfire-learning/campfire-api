class UsersController < ApplicationController
  # uncomment before deploying to production
  before_action :authenticate_user!

  def home
    app = Doorkeeper::Application.find_by(name: 'Web client')

    @application = {
      name: app.name,
      client_id: app.uid,
      client_secret: app.secret
    }
  end
end
