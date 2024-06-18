require "test_helper"

class ComputeClustersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get compute_clusters_index_url
    assert_response :success
  end

  test "should get show" do
    get compute_clusters_show_url
    assert_response :success
  end

  test "should get new" do
    get compute_clusters_new_url
    assert_response :success
  end

  test "should get edit" do
    get compute_clusters_edit_url
    assert_response :success
  end

  test "should get create" do
    get compute_clusters_create_url
    assert_response :success
  end

  test "should get update" do
    get compute_clusters_update_url
    assert_response :success
  end

  test "should get destroy" do
    get compute_clusters_destroy_url
    assert_response :success
  end
end
