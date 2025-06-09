require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "should get me" do
    sign_in users(:one)
    get root_url
    assert_response :success
  end
end
