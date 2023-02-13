# frozen_string_literal: true

require "test_helper"

class Public::UseItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_use_items_index_url
    assert_response :success
  end
end
