require 'test_helper'

class CommandesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get commandes_index_url
    assert_response :success
  end

  test "should get show" do
    get commandes_show_url
    assert_response :success
  end

  test "should get edit" do
    get commandes_edit_url
    assert_response :success
  end

  test "should get new" do
    get commandes_new_url
    assert_response :success
  end

end
