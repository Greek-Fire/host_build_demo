require "test_helper"

class HostnamesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get hostnames_new_url
    assert_response :success
  end

  test "should get show" do
    get hostnames_show_url
    assert_response :success
  end
end
