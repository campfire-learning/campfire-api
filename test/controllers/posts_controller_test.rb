require 'test_helper'

class Api::V1::PostsControllerTest < ActionDispatch::IntegrationTest
  test 'access of posts in Group' do
    app = Doorkeeper::Application.first_or_create(name: 'Web', redirect_uri: '', scopes: '')

    Group.first_or_create(
      name: 'Campfire General Group',
      creator_id: 1,
      public: 1
    )

    get '/api/v1/posts', params: { context_type: 'Group', context_id: 1 }
    assert_response :unauthorized

    post '/api/v1/users',
         params: { registration: { email: 'foo@bar.com', password: 'Password!23', client_id: app.uid } }
    assert_response :success

    access_token = response.parsed_body['access_token']
    get '/api/v1/posts',
        params: { context_type: 'Group', context_id: 1 },
        headers: { Authorization: "Bearer #{access_token}" }
    assert_response :success
  end
end
