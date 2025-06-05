require "test_helper"

class Api::V1::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get me" do
    get api_v1_profiles_me_url
    assert_response :success
  end
end
