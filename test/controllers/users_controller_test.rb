require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should not allow access to home without login' do
    Doorkeeper::Application.first_or_create(name: 'Web', redirect_uri: '', scopes: '')

    get root_url
    assert_response :redirect
  end
end
