require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect create if auth is blank" do
    get login_path('google_oauth2')
    assert_redirected_to root_url
  end
end
