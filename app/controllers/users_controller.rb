class UsersController < ApplicationController
  def home
    appl = Doorkeeper::Application.find_by(name: 'Web client')

    @application = {
      name: appl.name,
      client_id: appl.uid,
      client_secret: appl.secret
    }
  end
end
