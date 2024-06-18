require "test_helper"

class DatastoreClustersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get datastore_clusters_index_url
    assert_response :success
  end

  test "should get show" do
    get datastore_clusters_show_url
    assert_response :success
  end

  test "should get new" do
    get datastore_clusters_new_url
    assert_response :success
  end

  test "should get edit" do
    get datastore_clusters_edit_url
    assert_response :success
  end

  test "should get create" do
    get datastore_clusters_create_url
    assert_response :success
  end

  test "should get update" do
    get datastore_clusters_update_url
    assert_response :success
  end

  test "should get destroy" do
    get datastore_clusters_destroy_url
    assert_response :success
  end
end
