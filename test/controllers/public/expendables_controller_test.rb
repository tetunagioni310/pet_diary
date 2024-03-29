# frozen_string_literal: true

require "test_helper"

class Public::ExpendablesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_expendables_index_url
    assert_response :success
  end

  test "should get show" do
    get public_expendables_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_expendables_edit_url
    assert_response :success
  end
end
