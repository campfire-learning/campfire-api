require 'test_helper'

class Api::V1::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'should be able to register new user' do
    app = Doorkeeper::Application.first_or_create(name: 'Web', redirect_uri: '', scopes: '')

    u1 = User.first_or_create(
      email: 'marsh.mallow@campfire.com',
      password: 'to_be_determined_at_runtime',
      password_confirmation: 'to_be_determined_at_runtime',
      first_name: 'Marsh',
      last_name: 'Mallow',
      user_type: User.user_types[:bot]
    )

    g1 = Group.first_or_create(
      name: 'Campfire General Group',
      creator_id: u1.id,
      owner_id: u1.id,
      description: 'The group that includes all users',
      public: 1
    )
    puts "Group name is #{g1.name}"

    get '/api/v1/groups', params: { user_id: 1 }
    assert_response :unauthorized

    post '/api/v1/users',
         params: { registration: { email: 'foo@bar.com', password: 'Password!23', client_id: app.uid } }
    assert_response :success

    access_token = response.parsed_body['access_token']
    get '/api/v1/groups', params: { user_id: u1.id }, headers: { Authorization: "Bearer #{access_token}" }
    assert_response :success
  end
end
