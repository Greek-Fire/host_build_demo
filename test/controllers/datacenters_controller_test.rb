require "test_helper"

class DatacentersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get datacenters_index_url
    assert_response :success
  end

  test "should get show" do
    get datacenters_show_url
    assert_response :success
  end

  test "should get new" do
    get datacenters_new_url
    assert_response :success
  end

  test "should get edit" do
    get datacenters_edit_url
    assert_response :success
  end

  test "should get create" do
    get datacenters_create_url
    assert_response :success
  end

  test "should get update" do
    get datacenters_update_url
    assert_response :success
  end

  test "should get destroy" do
    get datacenters_destroy_url
    assert_response :success
  end
end
