require "test_helper"

class Public::FavoriteWorksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_favorite_works_index_url
    assert_response :success
  end
end
