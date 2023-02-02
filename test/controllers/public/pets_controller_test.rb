require 'test_helper'

class Public::PetsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get public_pets_index_url
    assert_response :success
  end

  test 'should get show' do
    get public_pets_show_url
    assert_response :success
  end
end
