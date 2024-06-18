require "test_helper"

class EsxHostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get esx_hosts_index_url
    assert_response :success
  end

  test "should get show" do
    get esx_hosts_show_url
    assert_response :success
  end

  test "should get new" do
    get esx_hosts_new_url
    assert_response :success
  end

  test "should get edit" do
    get esx_hosts_edit_url
    assert_response :success
  end

  test "should get create" do
    get esx_hosts_create_url
    assert_response :success
  end

  test "should get update" do
    get esx_hosts_update_url
    assert_response :success
  end

  test "should get destroy" do
    get esx_hosts_destroy_url
    assert_response :success
  end
end
