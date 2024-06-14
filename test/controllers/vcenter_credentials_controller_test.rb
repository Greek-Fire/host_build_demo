require "test_helper"

class VcenterCredentialsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get vcenter_credentials_new_url
    assert_response :success
  end

  test "should get create" do
    get vcenter_credentials_create_url
    assert_response :success
  end
end
