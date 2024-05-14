require "test_helper"

class GitSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get git_sessions_new_url
    assert_response :success
  end
end
