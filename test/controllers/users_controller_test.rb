require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    Doorkeeper::Application.create(name: 'Web', redirect_uri: '', scopes: '')

    get root_url
    assert_response :success
  end
end
