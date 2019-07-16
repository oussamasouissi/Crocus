require 'test_helper'

class CategorieControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get categorie_list_url
    assert_response :success
  end

end
