require "test_helper"

class Api::V1::ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @application = Doorkeeper::Application.create!(name: "Test App", redirect_uri: "https://example.com")

    @access_token = Doorkeeper::AccessToken.create!(
      resource_owner_id: @user.id,
      application: @application,
      expires_in: 1.hour,
      scopes: "public"
    )
  end

  test "should get me" do
    get api_v1_profiles_me_url, headers: {
      Authorization: "Bearer #{@access_token.token}"
    }

    assert_response :success

    json = JSON.parse(response.body)
    assert_equal @user.email, json["email"]
    assert_equal @application.name, json["application_name"]
  end
end
