require "test_helper"

class DatastoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get datastores_index_url
    assert_response :success
  end

  test "should get show" do
    get datastores_show_url
    assert_response :success
  end

  test "should get new" do
    get datastores_new_url
    assert_response :success
  end

  test "should get edit" do
    get datastores_edit_url
    assert_response :success
  end

  test "should get create" do
    get datastores_create_url
    assert_response :success
  end

  test "should get update" do
    get datastores_update_url
    assert_response :success
  end

  test "should get destroy" do
    get datastores_destroy_url
    assert_response :success
  end
end
