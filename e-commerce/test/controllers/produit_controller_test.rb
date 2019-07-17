require 'test_helper'

class ProduitControllerTest < ActionDispatch::IntegrationTest
  test "should get showAdmin" do
    get produit_showAdmin_url
    assert_response :success
  end

end
