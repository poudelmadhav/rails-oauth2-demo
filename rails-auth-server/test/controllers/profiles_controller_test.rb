require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get me" do
    get profiles_me_url
    assert_response :success
  end
end
