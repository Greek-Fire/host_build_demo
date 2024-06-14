require "test_helper"

class VcentersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vcenters_index_url
    assert_response :success
  end

  test "should get show" do
    get vcenters_show_url
    assert_response :success
  end

  test "should get new" do
    get vcenters_new_url
    assert_response :success
  end

  test "should get create" do
    get vcenters_create_url
    assert_response :success
  end
end
