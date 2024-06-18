require "test_helper"

class VmNetworksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vm_networks_index_url
    assert_response :success
  end

  test "should get show" do
    get vm_networks_show_url
    assert_response :success
  end

  test "should get new" do
    get vm_networks_new_url
    assert_response :success
  end

  test "should get edit" do
    get vm_networks_edit_url
    assert_response :success
  end

  test "should get create" do
    get vm_networks_create_url
    assert_response :success
  end

  test "should get update" do
    get vm_networks_update_url
    assert_response :success
  end

  test "should get destroy" do
    get vm_networks_destroy_url
    assert_response :success
  end
end
