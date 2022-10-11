require 'test_helper'

class Api::V1::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'should be able to register new user' do
    app = Doorkeeper::Application.first_or_create(name: 'Web', redirect_uri: '', scopes: '')

    Group.first_or_create(
      name: 'Campfire General Group',
      creator_id: 1,
      owner_id: 1,
      description: 'The group that includes all users',
      public: 1
    )

    post '/api/v1/users',
         params: { registration: { email: 'foo@bar.com', password: 'Password!23', client_id: app.uid } }

    assert_response :success
  end
end
