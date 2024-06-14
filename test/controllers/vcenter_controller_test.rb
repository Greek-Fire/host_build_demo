require "test_helper"

class VcenterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vcenter_index_url
    assert_response :success
  end
end
