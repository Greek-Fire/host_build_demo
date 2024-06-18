require "test_helper"

class VirtualMachinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get virtual_machines_index_url
    assert_response :success
  end

  test "should get show" do
    get virtual_machines_show_url
    assert_response :success
  end

  test "should get new" do
    get virtual_machines_new_url
    assert_response :success
  end

  test "should get edit" do
    get virtual_machines_edit_url
    assert_response :success
  end

  test "should get create" do
    get virtual_machines_create_url
    assert_response :success
  end

  test "should get update" do
    get virtual_machines_update_url
    assert_response :success
  end

  test "should get destroy" do
    get virtual_machines_destroy_url
    assert_response :success
  end
end
